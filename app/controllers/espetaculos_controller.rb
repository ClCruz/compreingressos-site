require 'digest'

class EspetaculosController < ApplicationController
  include MultiHelper
  before_filter :authorize, :except => [:index, :busca, :show, :home, :nobuilder, :paineis, :feed_espetaculos]
  newrelic_ignore :except => [:index, :busca, :show, :home, :nobuilder, :paineis]
  layout 'compreingressos_antigo'
  
  
  # GET /espetaculos
  # GET /espetaculos.xml
  def admin_index
    if params[:status] == 'Ativo'
      @espetaculos = Espetaculo.find(:all, :include => :teatro, :select => "espetaculos.id, espetaculos.nome, espetaculos.teatro_id", :conditions => {:ativo => true}, :order => :nome)
      @totalativos = @espetaculos
    elsif params[:status] == 'Inativo'
      @espetaculos = Espetaculo.find(:all, :include => :teatro, :select => "espetaculos.id, espetaculos.nome, espetaculos.teatro_id", :conditions => {:ativo => false}, :order => :nome)
      @totalativos = []
    elsif params[:status] == 'Privado'
      @espetaculos = Espetaculo.find(:all, :include => :teatro, :select => "espetaculos.id, espetaculos.nome, espetaculos.teatro_id", :conditions => {:privado => true}, :order => :nome)
      @totalativos = Espetaculo.find(:all, :select => "espetaculos.id", :conditions => {:privado => true, :ativo => true})
    elsif params[:status] == 'Especial'
      @espetaculos = Espetaculo.find(:all, :include => :teatro, :select => "espetaculos.id, espetaculos.nome, espetaculos.teatro_id", :conditions => {:especial => true}, :order => :nome)
      @totalativos = Espetaculo.find(:all, :select => "espetaculos.id", :conditions => {:especial => true, :ativo => true})
    else
      @espetaculos = Espetaculo.find(:all, :include => :teatro, :select => "espetaculos.id, espetaculos.nome, espetaculos.teatro_id, espetaculos.preco", :order => :nome)
      @totalativos = Espetaculo.find(:all, :select => "espetaculos.id, espetaculos.preco", :conditions => {:ativo => true})
    end
  end
  
  def index
    
    if params[:auto]
      if session[:cidade].blank?
        params[:cidade] = "Todas as cidades"
      end
    end
    
    pcidade = params[:cidade] == 'Todas as cidades' ? '' : params[:cidade]
    pgenero = params[:genero] == 'Todos os gêneros' ? '' : params[:genero]
    pdireto = params[:direto]

    @espetaculos = Espetaculo.ativo.nao_expirado

    unless(pcidade.blank? or !params[:cidade].present?)
      @cidade = Cidade.find_by_nome(pcidade, :include => :cidade_visores)
      @conjuntocidade = ConjuntoCidade.first(:include => [:conjunto_cidade_visores, :cidades], :joins => :cidades, :conditions => { :cidades => { :nome => pcidade } })

      if(@conjuntocidade)
        @cids = @conjuntocidade.cidade_ids.push(0).join(",")
        @espetaculos = @espetaculos.por_conjunto_cidade(@conjuntocidade.cidade_ids)
      else
        @espetaculos = @espetaculos.por_cidade(pcidade)
      end      
    end
    
    unless(pgenero.blank?)
      @genero = Genero.find_by_nome(pgenero)
      @espetaculos = @espetaculos.por_genero(pgenero)
    end

    # Caso tenha latitude e longitude
    if params[:latitude] and params[:longitude]
      @espetaculos = Espetaculo.ativo.nao_expirado if @espetaculos.empty?
      @espetaculos = @espetaculos.all(:origin => [params[:latitude],params[:longitude]], :within=>100, :order=>'distance ASC, espetaculos.relevancia DESC, espetaculos.nome ASC')
    end

    # Seleciona os visores e banners fixos para o modo mobile
    @visores = Visor.all(:conditions => ["data_de_expiracao >= ?", DateTime.now.in_time_zone('Brasilia')], :order => 'visores.order')
    @banner_fixos = BannerFixo.all(:order => "ordem DESC")



    # Define a ordem das queries
    if params[:ordem]=='destaques' or params[:ordem].blank?
      @espetaculos = @espetaculos.all(:order => 'espetaculos.relevancia DESC, espetaculos.nome ASC')
    elsif params[:ordem]=='alfabetica'
      @espetaculos = @espetaculos.all(:order => 'espetaculos.nome ASC')
    elsif params[:ordem]=='data'
      @espetaculos = @espetaculos.all(:joins => :horarios, :group => :id, :conditions => ["horarios.data >= ?", DateTime.now], :order => 'min(horarios.data)')
    end
    
    # GENEROS FORA DO PADRAO PARA RESPONDER AO APP
    if !pgenero.blank?
      if params[:genero].downcase == 'teatros'
        @espetaculos = Espetaculo.ativo.nao_expirado
        @espetaculos = @espetaculos.all(:joins => :teatro, :conditions => ["(teatros.nome LIKE ? OR espetaculos.genero_id = ?)", "%teatro%", 72])
      elsif params[:genero].downcase=='classicos' or params[:genero].downcase=='clássicos'
        @espetaculos = Espetaculo.ativo.nao_expirado
        @espetaculos = @espetaculos.all(:conditions => ["espetaculos.genero_id IN (25,61,65,91)"])
      end
    end

    if !params[:busca].blank?
      busca = params[:busca].first(50).split(' ').select{|w| w.length >= 2}.join(' ') if params[:busca]!='Nome da peça, teatro, local, elenco...'
      params[:busca] = busca
      @espetaculos = Espetaculo.search busca,
      :field_weights => {:nome => 100, :genero =>80, :teatro_nome => 80, :cidade => 70, :estado => 70, :keywords => 70, :endereco => 50, :bairro => 50, :entradas => 30},
      :match_mode => :any,
      :sort_mode => :extended,
      :order => "@relevance DESC",
      :index => "ativo",
      :per_page => 1000
    end

    if !@espetaculos or @espetaculos.size <= 0
      @espetaculos = Espetaculo.ativo.nao_expirado
      @espetaculos_vazio = 1
      @cidade = nil
      @conjuntocidade = nil
    end

    @title = "Espetáculos"

    @criteo_script_tag = criteo_category_script()

    respond_to do |format|
      format.html { render :layout => 'compreingressos', :action => @conjuntocidade ? 'index2' : 'index' }
      format.json if params[:key] == Espetaculo::KEY_TOKECOMPRE_APP # Para visualizar o json URL /espetaculos.json?key=8435D5115e46a70i6648715850882eus ainda é possivel filtrar por &cidade=, &genero= e por busca com o parametro &busca=
    end
  end
  
  def busca
    # Busca via texto eh processada pelo sphinx
    if !params[:busca].blank?
      busca = params[:busca].first(50).split(' ').select{|w| w.length >= 2}.join(' ') if params[:busca]!='Nome da peça, teatro, local, elenco...'
      params[:busca] = busca
      @espetaculos = Espetaculo.search busca,
      :field_weights => {:nome => 100, :genero =>80, :teatro_nome => 80, :cidade => 70, :estado => 70, :keywords => 70, :endereco => 50, :bairro => 50, :entradas => 30},
      :match_mode => :any,
      :sort_mode => :extended,
      :order => "@relevance DESC",
      :index => "ativo",
      :per_page => 1000
    end
    
    # Caso nenhum espetaculo seja encontrado
    if !@espetaculos or @espetaculos.size <= 0
      @espetaculos = Espetaculo.find(:all, :conditions => {:ativo => true}, :order => 'relevancia DESC')
      @espetaculos_vazio = 1
    end
    
    # Seleciona os visores e banners fixos para o modo mobile
    @visores = Visor.all(:conditions => ["data_de_expiracao >= ?", DateTime.now.in_time_zone('Brasilia')], :order => 'visores.order')
    @banner_fixos = BannerFixo.all(:order => "ordem DESC")
    
    @title = "Busca de espetáculos"
    respond_to do |format|
      format.html { render :layout => 'compreingressos', :action => 'busca' }
      format.json if params[:key] == Espetaculo::KEY_TOKECOMPRE_APP # Para visualizar o json URL /espetaculos.json?key=8435D5115e46a70i6648715850882eus ainda é possivel filtrar por &cidade=, &genero= e por busca com o parametro &busca=
    end
  end

  # GET /espetaculos/1
  # GET /espetaculos/1.xml
  def show
    #logger.error("1. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))

    @espetaculo = Espetaculo.find(params[:id], :include => :horarios_disponiveis)

    #logger.error("2. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))

    @title = @espetaculo.nome
    @keywords = @espetaculo.keywords
    @description = @espetaculo.description
    @pagina = flash[:pagina]

    #logger.error("3. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))

    @imagem = ENVIRONMENT_VARS['host']+@espetaculo.img_miniatura.url(:miniatura)

    #logger.error("4. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))

    # Conta visitas
    #sql = "UPDATE espetaculos SET visitas = visitas+1 WHERE id = #{@espetaculo.id};"
    #ActiveRecord::Base.connection.execute(sql)
    
    # Define o maximo de outros espetaculos para serem exibidos se for itaucard exibe mais se não exibe menos
    maximo_outros_espetaculos = 4
    if @espetaculo.pagina_especiais.include?(@espetaculo.pagina_especiais.find_by_id(1))
      maximo_outros_espetaculos = 6
    end

    #logger.error("5. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))

    # Variavel auxiliar para evitar que os espetaculos que já foram selecionados não sejam repetidos caso tenha a necessidade de ser executada uma nova query até completar o máximo de 4
    oe_ids = @espetaculo.id.to_s
    
    # Caso a origem esteja setada
    if params[:origem].blank?
      @pagina_especial = false
    elsif !params[:origem].blank? and params[:pacote].blank?
      # Busca a pagina especial de origem para checar se exibe o aviso se o botao for saiba_mais ao invés das datas de apresentação
      @pagina_especial = PaginaEspecial.find_by_url(params[:origem])
    end
    if !params[:origem].blank? and !params[:pacote].blank?
      @pacote = PaginaDePacote.find_by_url(params[:origem])
    end
    
    #logger.error("6. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))

    # Caso o usuário tenha vindo de uma página especial
    if @pagina_especial
      # Caso seja uma página especial privada
      if @pagina_especial.tipo == 2
        @outros_espetaculos = @pagina_especial.espetaculos.find(:all, :conditions => "(espetaculos.ativo = 1 or espetaculos.privado = 1) AND espetaculos.id NOT IN (#{oe_ids})", :order => 'espetaculos.relevancia DESC, RAND()', :limit => maximo_outros_espetaculos)
        @noheaderfooter = 1
        
      # Caso não
      else
        # Deve ser exibido somente espetaculos da mesma página especial
        @outros_espetaculos = @pagina_especial.espetaculos.find(:all, :conditions => "espetaculos.ativo = 1 AND espetaculos.id NOT IN (#{oe_ids})", :order => 'espetaculos.relevancia DESC, RAND()', :limit => maximo_outros_espetaculos)
      end

      @tt = 0
      if @pagina_especial.filtro_cidade
        @tt = @tt+222
      end
      if @pagina_especial.filtro_genero
        @tt = @tt+180
      end
      if @pagina_especial.busca
        if @tt==0
          @tt = 598
        else
          @tt = @tt+368
        end
      end
      #logger.error("7. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))

    # Caso o usuário não tenha vindo de uma página especial
    else
      # Espetaculos no mesmo teatro
      @outros_espetaculos = Espetaculo.find(:all,
                                            :include => :proximo_horario,
                                            :conditions => ["espetaculos.teatro_id = #{@espetaculo.teatro_id.to_s} AND espetaculos.id != #{@espetaculo.id.to_s} AND espetaculos.ativo = 1"],
                                            :order => 'espetaculos.relevancia DESC, espetaculos.nome ASC',
                                            :limit => maximo_outros_espetaculos)
      @outros_espetaculos.each do |esp|                                 
        oe_ids << ",#{esp.id}"

      #logger.error("8. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))

      end
                                            
      # Espetaculos na mesma cidade com o mesmo genero
      if @outros_espetaculos.size < maximo_outros_espetaculos
        e = Espetaculo.find(:all,
                            :include => :proximo_horario,
                            :joins => ["INNER JOIN teatros ON teatros.id = espetaculos.teatro_id",
                                       "INNER JOIN cidades ON cidades.id = teatros.cidade_id AND cidades.id = #{@espetaculo.teatro.cidade.id.to_s}"],
                            :conditions => ["espetaculos.genero_id = #{@espetaculo.genero_id.to_s} AND espetaculos.id != #{@espetaculo.id.to_s} AND espetaculos.ativo = 1 AND espetaculos.id NOT IN (#{oe_ids})"],
                            :order => 'espetaculos.relevancia DESC, espetaculos.nome ASC',
                            :limit => maximo_outros_espetaculos-@outros_espetaculos.size)
        if e.size > 0
          e.each do |esp|
            @outros_espetaculos << esp
            oe_ids << ",#{esp.id}"
          end
        end

        #logger.error("9. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))

      end
      
      # Espetaculos na mesma cidade
      if @outros_espetaculos.size < maximo_outros_espetaculos
        e = Espetaculo.find(:all,
                            :include => :proximo_horario,
                            :joins => ["INNER JOIN teatros ON teatros.id = espetaculos.teatro_id",
                                       "INNER JOIN cidades ON cidades.id = teatros.cidade_id AND cidades.id = #{@espetaculo.teatro.cidade.id.to_s}"],
                            :conditions => ["espetaculos.id != #{@espetaculo.id.to_s} AND espetaculos.ativo = 1 AND espetaculos.id NOT IN (#{oe_ids})"],
                            :order => 'espetaculos.relevancia DESC, espetaculos.nome ASC',
                            :limit => maximo_outros_espetaculos-@outros_espetaculos.size)
        if e.size > 0
          e.each do |esp|
            @outros_espetaculos << esp
            oe_ids << ",#{esp.id}"
          end
        end

        #logger.error("10. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
      end
      
      # Espetaculos randomicamente
      if @outros_espetaculos.size < maximo_outros_espetaculos
        e = Espetaculo.find(:all,
                            :include => :proximo_horario,
                            :order => 'espetaculos.relevancia DESC, espetaculos.nome ASC',
                            :conditions => ["espetaculos.id NOT IN (#{oe_ids}) AND espetaculos.ativo = 1"],
                            :limit => maximo_outros_espetaculos-@outros_espetaculos.size)
        if e.size > 0
          e.each do |esp|
            @outros_espetaculos << esp
          end
        end
        #logger.error("11. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
      end

    end
    
    # Transform temporada to be redable by humans
    if !@espetaculo.data_inicial.blank? and !@espetaculo.data_maxima.blank?
      d1 = @espetaculo.data_inicial.strftime('%d')
      d2 = @espetaculo.data_maxima.strftime('%d')
      m1 = @espetaculo.data_inicial.strftime('%m')
      m2 = @espetaculo.data_maxima.strftime('%m')
      a1 = @espetaculo.data_inicial.strftime('%Y')
      a2 = @espetaculo.data_maxima.strftime('%Y')

      #logger.error("12. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
      
      if a1!=a2
        @temporada = "#{l @espetaculo.data_inicial, :format => "%d de %B de %Y"} a #{l @espetaculo.data_maxima, :format => "%d de %B de %Y"}"
      else  
        if m1!=m2
          @temporada = "#{l @espetaculo.data_inicial, :format => "%d de %B"} a #{l @espetaculo.data_maxima, :format => "%d de %B de %Y"}"
        else
          if d1!=d2
            @temporada = "#{l @espetaculo.data_inicial, :format => "%d"} a #{l @espetaculo.data_maxima, :format => "%d de %B de %Y"}"
          else
            @temporada = l @espetaculo.data_maxima, :format => "%d de %B de %Y"
          end
        end
      end
    else
      @temporada = ''
    end

    #logger.error("13. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
    
    # Check if it's time to update the dates and/or allow the selling
    datetimenow = DateTime.now.in_time_zone.-3.hours
    #logger.warn "\n\n\n\n\n\n############"
    #logger.info datetimenow
    #logger.warn "#{@espetaculo.especificar_data_inicial_de_venda} #{@espetaculo.data_inicial_de_venda} <= #{datetimenow} = #{@espetaculo.data_inicial_de_venda<=datetimenow ? 'sim':'nao'}"
    if @espetaculo.cc_id# and (Rails.env=="production" or Rails.env=="staging")
      #logger.error("13.1. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
      if !@espetaculo.especificar_data_inicial_de_venda and @espetaculo.horario_cache<(datetimenow-30.minutes)
        #logger.error("13.2. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
        updatedates
        #logger.error("13.3. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
        Rails.logger.level = 0 # at any time
        @espetaculo.save false
        #logger.error("13.4. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
        @espetaculo = Espetaculo.find_by_id(params[:id], :include => :horarios_disponiveis)
        #logger.error("13.5. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))        
      elsif @espetaculo.especificar_data_inicial_de_venda and @espetaculo.data_inicial_de_venda <= datetimenow
        #logger.error("13.6. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
        updatedates
        #logger.error("13.7. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
        @espetaculo.especificar_data_inicial_de_venda = false
        #logger.error("13.8. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
        @espetaculo.save false
        #logger.error("13.9. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
        @espetaculo = Espetaculo.find_by_id(params[:id], :include => :horarios_disponiveis)
        #logger.error("13.10. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
      end
    end

    #logger.error("14. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))

    @criteo_script_tag = criteo_product_script()
    #logger.warn "############ \n\n\n\n\n\n"
    #logger.info @espetaculo.pagina_especiais.map { |d| d.nome}

    #logger.error("15. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
    
    respond_to do |format|
      if @espetaculo.especial
        format.html { render :layout => 'compreingressos', :action => 'show_especial' }
      else
        format.html { render :layout => 'compreingressos', :action => 'show' }
      end
    end

    #logger.error("16. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
  end
  
  # GET /espetaculos/new
  # GET /espetaculos/new.xml
  def new
    @espetaculo = Espetaculo.new
    @espetaculo.desconto = "50% para pessoas de idade igual ou superior a 60 anos. \n50% para estudantes."
    @espetaculo.data_inicial_de_venda = @espetaculo.data_inicial_de_venda

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /espetaculos/1/edit
  def edit
    @espetaculo = Espetaculo.find(params[:id])
    @espetaculo.data_inicial_de_venda = @espetaculo.data_inicial_de_venda
    #if @espetaculo.desconto.blank? and !@espetaculo.preco.blank?
    #  @espetaculo.desconto = "50% para pessoas de idade igual ou superior a 60 anos. \n50% para estudantes."
    #end
  end

  # POST /espetaculos
  # POST /espetaculos.xml
  def create
    @espetaculo = Espetaculo.new(params[:espetaculo])
    @espetaculo.data_inicial_de_venda = @espetaculo.data_inicial_de_venda
    
    respond_to do |format|
      if @espetaculo.save
        updatedates

        #@espetaculo.send_miniatura_ftp

        flash[:notice] = 'Espetaculo was successfully created.'
        format.html { redirect_to("/espetaculos/datas?id=#{@espetaculo.id}") }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /espetaculos/1
  # PUT /espetaculos/1.xml
  def update
    params[:espetaculo][:pagina_especial_ids] ||= []
    params[:espetaculo][:pagina_especial_filtro_ids] ||= []
    @espetaculo = Espetaculo.find(params[:id])
    @espetaculo.data_inicial_de_venda = @espetaculo.data_inicial_de_venda
    
    respond_to do |format|
      if @espetaculo.update_attributes(params[:espetaculo])
        updatedates

        #@espetaculo.send_miniatura_ftp

        flash[:notice] = 'Espetaculo was successfully updated.'
        format.html { redirect_to(@espetaculo) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /espetaculos/1
  # DELETE /espetaculos/1.xml
  def destroy
    @espetaculo = Espetaculo.find(params[:id])
    @espetaculo.destroy

    respond_to do |format|
      format.html { redirect_to(espetaculos_url) }
    end
  end
  
  def home
    # Caso não seja uma busca
    if (!params[:cidade].blank? or !params[:genero].blank?)
      # Selecionado o genero
      if (!params[:cidade].blank? and params[:genero].blank?)
        cidade = Cidade.find_by_nome(params[:cidade])
        if cidade
          @espetaculos_home = cidade.espetaculos.find(:all, :conditions => "espetaculos.ativo = 1", :order => :nome)
        end

      # Selecionado a cidade
      elsif (params[:cidade].blank? and !params[:genero].blank?)
        genero = Genero.find_by_nome(params[:genero])
        if genero
          @espetaculos_home = genero.espetaculos.find(:all, :conditions => "espetaculos.ativo = 1", :order => :nome)
        end

      # Selecionado a cidade e o genero
      elsif (!params[:cidade].blank? and !params[:genero].blank?)
        cidade = Cidade.find_by_nome(params[:cidade])
        genero = Genero.find_by_nome(params[:genero])
        @espetaculos_home = Espetaculo.find(:all, :conditions => "espetaculos.ativo = 1 AND espetaculos.genero_id = #{genero.id}",
                                             :joins => ["INNER JOIN teatros ON teatros.id = espetaculos.teatro_id",
                                                        "INNER JOIN cidades ON cidades.id = teatros.cidade_id AND cidades.id = #{cidade.id.to_s}"],
                                             :order => :nome)
      end
      
    # Caso seja uma busca
    elsif (!params[:busca].blank?)
      busca = params[:busca]=='Nome da peça, teatro, local, elenco...' ? '':params[:busca].first(50)
      unless busca.blank?    
        @espetaculos_home = Espetaculo.search busca,
        :field_weights => {:nome => 100, :genero =>80, :teatro_nome => 80, :cidade => 70, :estado => 70, :keywords => 70, :endereco => 50, :bairro => 50, :entradas => 30},
        :match_mode => :any,
        :sort_mode => :extended,
        :order => "@relevance DESC",
        :index => "geral"
      end
      
    # Caso seja listagem
    else
      # Verifica se foi setada alguma cidade se não seta São Paulo
      unless session[:cidade_id]
        session[:cidade_id] = 1
      end
      
      # Busca os espetaculos da home conforme a cidade do usuário
      cidade = Cidade.find(session[:cidade_id])
      espetaculos_home = cidade.home.espetaculos
      outras_localidades = cidade.outras_localidade.espetaculos if cidade.outras_localidade && cidade.outras_localidade.espetaculos.size > 0
      
      # Atribui a um array os espetaculos na ordem de exibição da home
      @espetaculos_home = []
      ids = ''
      espetaculos_home.each do |e| # Espetaculos da home
        ids << e.id.to_s+','
        @espetaculos_home << e
      end
      outras_localidades.each do |e| # Espetaculos da localidade do usuário
        ids << e.id.to_s+','
        @espetaculos_home << e
      end
      ids << '0'
      
      espetaculos = Espetaculo.find(:all, :conditions => "espetaculos.id NOT IN (#{ids}) AND espetaculos.ativo = 1", :order => :nome)
      
      # Após os espetaculos terem sido procurados filtrados isto vai fazer com que eles entrem em ordem para serem exibidos
      espetaculos.each do |e|
        @espetaculos_home << e
      end
    end
    
    respond_to do |format|
      format.xml if params[:key] == Espetaculo::KEY_FACEBOOK_APP
    end
  end
  
  # Responde XML para a loja APP do facebook, é possivel fazer uma busca como no link /espetaculos?cidadae=XX ou ?busca=XX
  def nobuilder
    # Caso não seja uma busca
    if params[:busca].blank?
      # Verifica se foi setada alguma cidade se não seta São Paulo
      unless session[:cidade_id]
        session[:cidade_id] = 1
      end
      
      # Busca os espetaculos da home conforme a cidade do usuário
      cidade = Cidade.find(session[:cidade_id])
      espetaculos_home = cidade.home.espetaculos
      outras_localidades = cidade.outras_localidade.espetaculos if cidade.outras_localidade && cidade.outras_localidade.espetaculos.size > 0
      
      # Atribui a um array os espetaculos na ordem de exibição da home
      @espetaculos_home = []
      ids = ''
      espetaculos_home.each do |e| # Espetaculos da home
        ids << e.id.to_s+','
        @espetaculos_home << e
      end
      outras_localidades.each do |e| # Espetaculos da localidade do usuário
        ids << e.id.to_s+','
        @espetaculos_home << e
      end
      ids << '0'

      # Selecionado o genero
      if (!params[:cidade].blank? and params[:genero].blank?)
        cidade = Cidade.find_by_nome(params[:cidade])
        if cidade
          espetaculos = cidade.espetaculos.find(:all, :conditions => "espetaculos.id NOT IN (#{ids}) AND espetaculos.ativo = 1", :order => :nome)
        end

      # Selecionado a cidade
      elsif (params[:cidade].blank? and !params[:genero].blank?)
        genero = Genero.find_by_nome(params[:genero])
        if genero
          espetaculos = genero.espetaculos.find(:all, :conditions => "espetaculos.id NOT IN (#{ids}) AND espetaculos.ativo = 1", :order => :nome)
        end

      # Selecionado a cidade e o genero
      elsif (!params[:cidade].blank? and !params[:genero].blank?)
        cidade = Cidade.find_by_nome(params[:cidade])
        genero = Genero.find_by_nome(params[:genero])
        espetaculos = Espetaculo.find(:all, :conditions => "espetaculos.id NOT IN (#{ids}) AND espetaculos.ativo = 1 AND espetaculos.genero_id = #{genero.id}",
                                             :joins => ["INNER JOIN teatros ON teatros.id = espetaculos.teatro_id",
                                                        "INNER JOIN cidades ON cidades.id = teatros.cidade_id AND cidades.id = #{cidade.id.to_s}"],
                                             :order => :nome)
      
      # Sem filtro
      else
        espetaculos = Espetaculo.find(:all, :conditions => "espetaculos.id NOT IN (#{ids}) AND espetaculos.ativo = 1", :order => :nome)
      end
      
      # Após os espetaculos terem sido procurados filtrados isto vai fazer com que eles entrem em ordem para serem exibidos
      espetaculos.each do |e|
        @espetaculos_home << e
      end

      @criteo_script_tag = criteo_category_script
    # Caso seja uma busca
    else
      busca = params[:busca]=='Nome da peça, teatro, local, elenco...' ? '':params[:busca].first(50)
      unless busca.blank?    
        @espetaculos_home = Espetaculo.search busca,
        :field_weights => {:nome => 100, :genero =>80, :teatro_nome => 80, :cidade => 70, :estado => 70, :keywords => 70, :endereco => 50, :bairro => 50, :entradas => 30},
        :match_mode => :any,
        :sort_mode => :extended,
        :order => "@relevance DESC",
        :index => "geral"
      end
    end
    
    respond_to do |format|
      format.xml if params[:key] == Espetaculo::KEY_FACEBOOK_APP
    end
  end
  
  # Exclui a imagem desejada no formulario de administracao
  def excluir_img
    @espetaculo = Espetaculo.find(params[:id])
    if params[:tipo]=='fundo'
      @espetaculo.fundo.clear
    elsif params[:tipo]=='img_principal'
      @espetaculo.img_principal.clear
    elsif params[:tipo]=='img_miniatura'
      @espetaculo.img_miniatura.clear
    elsif params[:tipo]=='img_destaque'
      @espetaculo.img_destaque.clear
    end
    @espetaculo.save
    redirect_to(edit_espetaculo_path(@espetaculo))
  end
  
  # Mostra todas as datas de apresentação do espetaculo escolhido
  def datas
    @espetaculo = Espetaculo.find(params[:id], :include => :horarios)
  end
  
  # Grava as datas que tiveram entrada manual no sistema e não foi pego pelo sistema da C&C
  def datas_gravar
    Horario.delete_all(:espetaculo_id => params[:id])
    unless params[:data].blank?
      params[:data].each do |v|
        horario = Horario.new(:data => v, :espetaculo_id => params[:id])
        horario.save
      end
    end
    redirect_to(espetaculo_path(Espetaculo.find(params[:id])))
  end
  
  # Provide information about the shows for tv panels into the teathers
  # REQUEST URL http://www.compreingressos.com/espetaculos/paineis.json?id=24&key=b12fa2e6c650eafe870209e7eadb13f2
  def paineis
    @espetaculos = Espetaculo.find(:all, :conditions => ["espetaculos.ativo = 1 AND espetaculos.teatro_id = ?",params[:id]], :include => :horarios, :order => 'relevancia DESC')
    
    respond_to do |format|
      format.json if params[:key] == Espetaculo::KEY_PAINEIS_TEATROS
    end
  end
  
  def exportar
    require("cgi")
    @espetaculos = Espetaculo.find_by_sql("SELECT c.estado AS 'estado', c.nome AS 'cidaden', t.nome AS 'teatron', e.nome AS 'espetaculo', g.nome AS 'generon', e.data_inicial AS 'tinicio', e.data_maxima AS 'ttermino', e.sinopse AS 'sinopse' FROM cidades AS c, teatros AS t, espetaculos AS e, generos AS g WHERE e.teatro_id = t.id AND t.cidade_id = c.id AND e.genero_id = g.id AND e.ativo = 1 AND g.id NOT IN (5,40,75) ORDER BY c.estado, c.nome, t.nome, e.nome, g.nome")
    #SELECT c.estado AS 'Estado', c.nome AS 'Cidade', t.nome AS 'Teatro', e.nome AS 'Espetáculo', g.nome AS 'Gênero', e.data_inicial AS 'Temporada inicio', e.data_maxima AS 'Temporada término', e.sinopse AS 'Sinopse' FROM cidades AS c, teatros AS t, espetaculos AS e, generos AS g WHERE e.teatro_id = t.id AND t.cidade_id = c.id AND e.genero_id = g.id AND e.ativo = 1 AND g.id NOT IN (5,40,75) ORDER BY c.estado, c.nome, t.nome, e.nome, g.nome
    
    # remove html markup from 'sinopse'
    strip_html_tags()
    
    @espetaculos.each_with_index do |e, i|
      @espetaculos[i].tinicio = "0000-00-00" if e.tinicio.blank?
      @espetaculos[i].ttermino = "0000-00-00" if e.ttermino.blank?
      @espetaculos[i].sinopse = Hpricot.uxs(CGI.unescapeHTML(e.sinopse))
    end
    
    #render :layout => false
    respond_to do |format|
      format.csv
    end
  end

  # feed para integração com a Criteo
  def feed_espetaculos
    @espetaculos = Espetaculo.all(:limit => 20000, :order => "created_at DESC", :include => [:teatro, :cidade, :genero])
    
    # remove html markup from 'sinopse'
    strip_html_tags()

    respond_to do |format|
      format.rss { render :layout => false }
    end

  end
  
  private
  def updatedates
    if @espetaculo.cc_id# and (Rails.env=="production" or Rails.env=="staging")
      begin
        #logger.warn "\n\n\n\n\n"
        require 'open-uri'
        require 'json'
        logger.error("updatedates - 1. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S") + " - "  + ENVIRONMENT_VARS['host_json'])
        #logger.warn "#{ENVIRONMENT_VARS['host_json']}/comprar/timeTable.php?evento=#{@espetaculo.cc_id}"
        #doc = open("#{ENVIRONMENT_VARS['host_json']}/comprar/timeTable.php?evento=4617") # Development environment
        doc = open("#{ENVIRONMENT_VARS['host_json']}/comprar/timeTable.php?evento=#{@espetaculo.cc_id}")
        logger.error("updatedates - 2. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
        doc.rewind
        logger.error("updatedates - 3. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
        data = doc.readlines.join("\n").strip
        logger.error("updatedates - 4. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
        #logger.warn data
        # Exclude the past appearances
        Horario.delete_all(["espetaculo_id = ?",@espetaculo.id])
        logger.error("updatedates - 5. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
        if !data.blank?
          logger.error("updatedates - 6. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
          # Request all the existent appearances
          idapre = Horario.find(:all, :select => :id_apresentacao, :conditions => {:espetaculo_id => @espetaculo.id}, :order => :data)
          logger.error("updatedates - 7. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
          #logger.warn idapre.inspect
          # Transform json to array         
          apresentacoes = JSON.parse(data)
          logger.error("updatedates - 8. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
          apresentacoes['horarios'].each do |a|
            logger.error("updatedates - 9. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
            # Check if the ID appearance exists in the database (it's just to avoid possible duplications)
            if !idapre.map(&:id_apresentacao).include?(a['idApresentacao'])
              logger.error("updatedates - 10. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
              dt = DateTime.parse("#{a['nAno']}-#{a['nMes']}-#{a['nDia']} #{a['nHora']}:#{a['nMinuto']}:00")#.in_time_zone
              # Check if the appearance date is further than the date now
              #logger.warn "#{dt} >= #{(DateTime.now-3.hours).in_time_zone}"
              if dt >= (DateTime.now-3.hours)#.in_time_zone
                logger.error("updatedates - 11. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
                #logger.warn "Yes"
                horario = Horario.new(:data => dt, :espetaculo_id => @espetaculo.id, :id_apresentacao => a['idApresentacao'])
                horario.save
                logger.error("updatedates - 12. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
              else
                logger.error("updatedates - 13. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S"))
                #logger.warn "No"
              end
            end
          end
        end
      rescue Exception => e
        logger.error("updatedates - -99. - " + DateTime.now.in_time_zone('Brasilia').strftime("Printed on %m/%d/%Y at %H:%M:%S") + "--- " + e.message)
        # Do nothing for now...
        #logger.warn e.inspect
        #@espetaculo.cc_id = ''
        #@errocc = 'Vendas temporariamente indisponíveis. Voltaremos em alguns instantes.'
      end
    else
      # Exclude the past appearances
      Horario.delete_all(["espetaculo_id = ?",@espetaculo.id])
    end
  end

  def strip_html_tags
    # patterns to be removed
    replacements = [
                    ['"', '“'],
                    ["<br>", "\r\n"],
                    ["<br />", "\r\n"],
                    ["<strong>", ""],
                    ["</strong>", ""],
                    ["<b>", ""],
                    ["</b>", ""],
                    ["<i>", ""],
                    ["</i>", ""],
                    ["<u>", ""],
                    ["</u>", ""],
                    ["<em>", ""],
                    ["</em>", ""],
                    ["<p>", ""],
                    ["<p class=“p1“>", ""],
                    ["<p class=“p2“>", ""],
                    ["</p>", ""],
                    ["<div>", ""],
                    ["</div>", ""],
                    ["<span>", ""],
                    ["</span>", ""],
                    ["<span lang=“PT“>", ""],
                    ["<span style=“white-space: pre;“>", ""],
                    ["<div class=“page“ title=“Page 1“>", ""],
                    ["<div class=“layoutArea“>", ""],
                    ["<div class=“column“>", ""]
                   ]
    
    @espetaculos.each do |e|
      replacements.each { |replacement| e.sinopse.gsub!(replacement[0], replacement[1]) }
    end
  end

  def criteo_category_script
    productIDList = @espetaculos.map { |item| item.cc_id.to_s }

    if params[:genero].present?
       "dataLayer.push({
          'PageType': 'Listingpage',
          'HashedEmail': '', 
          'ProductIDList': [#{productIDList.join(',')}]
        });"
    else
      nil
    end
  end

  def criteo_product_script
        
    "dataLayer.push({
      'PageType': 'Productpage',
      'HashedEmail': '', 
      'ProductID': '#{@espetaculo.cc_id unless @espetaculo.nil? }'
    });"
  end

#  def setaalturadeiniciomobile
#    espetaculos = Espetaculo.find(:all, :conditions => ["altura_de_inicio IS NOT NULL"])
#    espetaculos.each do |e|
#      a = e.altura_de_inicio/5.8
#      e.altura_de_inicio_mobile = a.round()
#      e.save
#    end
#    render :text => "#### SUCESSO ####"
#  end
#  
#  def readicionahorarios
#    espetaculos = Espetaculo.find(:all, :conditions => ["cc_id IS NOT NULL"])
#    espetaculos.each do |e|
#      begin
#        require 'open-uri'
#        require 'json'    
#        
#        doc = open("#{ENVIRONMENT_VARS['host_json']}/comprar/timeTable.php?evento=#{e.cc_id}")
#        
#        doc.rewind
#        data = doc.readlines.join("\n").strip
#        if !data.blank?
#          apresentacoes = JSON.parse(data)
#          Horario.delete_all(:espetaculo_id => e.id)
#          apresentacoes['horarios'].each do |a|
#            dt = DateTime.parse "#{a['nAno']}-#{a['nMes']}-#{a['nDia']} #{a['nHora']}:#{a['nMinuto']}:00"
#            horario = Horario.new(:data => dt, :espetaculo_id => e.id, :id_apresentacao => a['idApresentacao']))
#            horario.save
#          end
#        end
#      rescue Exception => e
#        
#      end
#    end
#    render :text => "#### SUCESSO ####"
#  end
#
## Envia miniaturas para o servidor da C&C quando o usuario FTP parou de funcionar
#  def atualizaminiaturas
#    @espetaculos = Espetaculo.find(:all, :conditions => ["cc_id IS NOT NULL and updated_at >= ?", 1.week.ago], :order => :id)
#    
#    total = 0
#    @espetaculos.each do |e|
#      arquivo = "#{RAILS_ROOT}/public/images/espetaculos/#{e.id}/miniatura.jpg"
#      if File.exist?(arquivo)
#        e.nome = e.nome
#        if e.save
#          total = total+1
#        end
#      end
#    end
#    render :text => "#### SUCESSO #### <br />Total espetaculos: #{@espetaculos.size}<br />Total 'enviado': #{total}"
#  end
#
## Envia as miniaturas para o servidor da C&C  
#  def ccminiaturas
#    @espetaculos = Espetaculo.find(:all, :conditions => ["cc_id IS NOT NULL"], :order => :id)
#    total = 0
#    @espetaculos.each do |e|
#      arquivo = "#{RAILS_ROOT}/public/images/espetaculos/#{e.id}/miniatura.jpg"
#      if File.exist?(arquivo)
#        FileUtils.cp(arquivo,"#{RAILS_ROOT}/public/cc_compra_images/#{e.cc_id}.jpg")
#        total = total+1
#      end
#    end
#    render :text => "#### SUCESSO #### <br />Total espetaculos: #{@espetaculos.size}<br />Total 'enviado': #{total}"
#  end
#
## Redimensiona as imagens da antiga pasta /cache para o novo formato  
#  def resize
#    # LINK DA URL PARA CONVERSAO
#    # http://localhost:3000/espetaculos/resize?i=800&f=100
#    # A partir do espetaculo 800 pegar os proximos 100
#    nc = [] #not converted
#    nu = [] #not updated
#    ai = [] #already has image
#    eu = [] #espetaculo updated
#    @espetaculos = Espetaculo.find(:all, :order => :id, :limit => params[:f], :offset => params[:i])
#    @espetaculos.each do |e|
#      if e.imagems.size >= 2 and 1==0
#        if !e.img_principal? and !e.img_miniatura?
#          i1 = File.open("#{RAILS_ROOT}/public/cache/#{e.imagems[0].id.to_s}_visor.jpg")
#          i2 = File.open("#{RAILS_ROOT}/public/cache/#{e.imagems[1].id.to_s}_destaque.jpg")
#        end
#        
#        g = []
#        i = 1
#        while i < e.imagems.size
#          i3 = File.open("#{RAILS_ROOT}/public/cache/#{e.imagems[i].id.to_s}.jpg")
#          g << { :imagem => i3, :legenda => e.imagems[i].legenda}
#          i+=1
#        end
#        
#        if e.relevancia > 1
#          rel = e.relevancia
#        else
#          rel = 1
#        end
#        
#        if !e.img_principal? and !e.img_miniatura?
#          espetaculo = {:relevancia => rel, :img_principal => i1, :img_miniatura => i2, :galerias_attributes => g, :cor_dos_botoes => 1}
#        else
#          espetaculo = {:relevancia => rel, :galerias_attributes => g, :cor_dos_botoes => 1}
#          ai << e.id
#        end
#        
#        if e.update_attributes(espetaculo)
#          eu << e.id
#        else
#          nu << e.id
#        end
#        logger.info("#################")
#        logger.info(e.errors.full_messages.to_sentence)
#      else
#        nc << e.id
#      end
#    end
#    logger.info("#################")
#    logger.info("Não convertidos: 0#{nc.collect{|v| ", #{v}"}.join}")
#    logger.info("Não atualizados: 0#{nu.collect{|v| ", #{v}"}.join}")
#    logger.info("Miniatura e header existentes: 0#{ai.collect{|v| ", #{v}"}.join}")
#    logger.info("#################")
#    logger.info("Atualizados: 0#{eu.collect{|v| ", #{v}"}.join}")
#    logger.info("#################")
#    render :text => "#### SUCESSO #### <br /><br />Started in: #{params[:i]} (ID: #{@espetaculos.first.id})<br />Ended in: #{params[:f].to_i+params[:i].to_i-1} (ID: #{@espetaculos.last.id})"
#  end
#
## Re-upload a imagem para gerar ela mesma com o dobro do tamanho (320px)
#  def thumbnailsconverter
#    nc = [] #not converted
#    nu = [] #not updated
#    ai = [] #already has image
#    eu = [] #espetaculo updated
#    @espetaculos = Espetaculo.find(:all, :order => :id, :limit => params[:f], :offset => params[:i])
#    @espetaculos.each do |e|
#      if e.img_miniatura?
#        arquivo = "#{RAILS_ROOT}/public/images/espetaculos/#{e.id}/miniatura.jpg"
#        if File.exist?(arquivo)
#          img = File.open(arquivo)
#          espetaculo = {:img_miniatura => img}
#        end
#      else
#        nc << e.id
#      end
#      
#      if e.update_attributes(espetaculo)
#        eu << e.id
#      else
#        nu << e.id
#      end
#      logger.info("#################")
#      logger.info(e.errors.full_messages.to_sentence)
#    end
#    logger.info("#################")
#    logger.info("Não convertidos: 0#{nc.collect{|v| ", #{v}"}.join}")
#    logger.info("Não atualizados: 0#{nu.collect{|v| ", #{v}"}.join}")
#    logger.info("#################")
#    logger.info("Atualizados: 0#{eu.collect{|v| ", #{v}"}.join}")
#    logger.info("#################")
#    render :text => "#### SUCESSO #### <br /><br />Started in: #{params[:i]} (ID: #{@espetaculos.first.id})<br />Ended in: #{params[:f].to_i+params[:i].to_i-1} (ID: #{@espetaculos.last.id})"    
#  end
end
