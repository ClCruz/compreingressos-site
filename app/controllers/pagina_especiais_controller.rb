class PaginaEspeciaisController < ApplicationController
  before_filter :authorize, :except => [:show]
  newrelic_ignore :except => [:show]
  layout 'compreingressos_antigo'
  
  # GET /pagina_especiais
  # GET /pagina_especiais.xml
  def index
    @pagina_especiais = PaginaEspecial.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pagina_especiais }
    end
  end

  # GET /pagina_especiais/1
  # GET /pagina_especiais/1.xml
  def show
    if params[:id].blank?
      @pagina_especial = PaginaEspecial.find(:first, :conditions => {:url => params[:url]})
    else
      @pagina_especial = PaginaEspecial.find(params[:id])
    end

    if !@pagina_especial.nil?
      @keywords = @pagina_especial.keywords
      @description = @pagina_especial.description
      @origem = @pagina_especial.url

      # Page type conditionals
      if @pagina_especial.tipo == 1
        #cond = "espetaculos.ativo = 1 AND espetaculos.privado = 0" # Até 04/2015 era proibido exibir espetaculos privados ativos nas páginas especiais normais
        cond = "(espetaculos.ativo = 1 AND espetaculos.data_maxima >= '#{DateTime.now}')"
      elsif @pagina_especial.tipo == 2
        #cond = "(espetaculos.ativo = 1 AND espetaculos.privado = 1) OR espetaculos.ativo = 1 OR espetaculos.privado = 1"
        cond = "((espetaculos.ativo = 1 AND espetaculos.data_maxima >= '#{DateTime.now}') OR espetaculos.privado = 1)"
        #cond = "1=1"
        @noheaderfooter = 1
      end

      # Filter conditionals add
      @innerjoin = ""
      if !params[:filtro].blank?
        @pef = PaginaEspecialFiltro.find_by_url(params[:filtro])
        @innerjoin = "INNER JOIN espetaculos_pagina_especial_filtros AS epef ON epef.espetaculo_id = espetaculos.id AND epef.pagina_especial_filtro_id = #{@pef.id}" if params[:todos]!="sim"
      end


      # Measure the size of the layout filters
      @tt = 0
      if @pagina_especial.filtro_cidade
        @tt = @tt+122
      end
      if @pagina_especial.filtro_genero
        @tt = @tt+110
      end
      if @pagina_especial.busca
        if @tt==0
          @tt = 360
        else
          @tt = @tt+222
        end
      end
      
      
      # Define a ordem das queries
      if !params[:ordem].blank?
        if params[:ordem]=='destaques'
          order = 'espetaculos.relevancia DESC, espetaculos.nome ASC'
        elsif params[:ordem]=='alfabetica'
          order = 'espetaculos.nome ASC'
        elsif params[:ordem]=='data'
          order = 'min(horarios.data) ASC, espetaculos.relevancia DESC, espetaculos.nome ASC'
        end
      else
        if @pagina_especial.organizado_por == 1
          order = 'espetaculos.relevancia DESC, espetaculos.nome ASC'
        elsif @pagina_especial.organizado_por == 2
          order = 'espetaculos.nome ASC'
        elsif @pagina_especial.organizado_por == 3
          order = 'min(horarios.data) ASC, espetaculos.relevancia DESC, espetaculos.nome ASC'
        end
      end


      pcidade = params[:pecidade]=='Todas as cidades' ? '':params[:pecidade]
      pgenero = params[:pegenero]=='Todos os gêneros' ? '':params[:pegenero]
  
      # Caso tenha cidade mas nao tenha genero
      if (!pcidade.blank? and pgenero.blank?)
        @pecidade = Cidade.find_by_nome(pcidade)
        if @pecidade
          
          # Caso não seja ordenado por data
          if (params[:ordem].blank? and @pagina_especial.organizado_por!=3) or (params[:ordem]!='data' and @pagina_especial.organizado_por!=3)
            @espetaculos = Espetaculo.find(:all,
                                           :select => 'espetaculos.*',
                                           :conditions => [cond],
                                           :joins => ["INNER JOIN teatros ON teatros.id = espetaculos.teatro_id",
                                                      "INNER JOIN cidades ON teatros.cidade_id = cidades.id AND cidades.id = #{@pecidade.id}",
                                                      "INNER JOIN espetaculos_pagina_especiais ON espetaculos.id = espetaculos_pagina_especiais.espetaculo_id AND espetaculos_pagina_especiais.pagina_especial_id = #{@pagina_especial.id}",
                                                      @innerjoin],
                                           :order => order)
                                           
            
                                           
          # Caso seja ordenado por data
          else
            @espetaculos = []
            ids = "0"
            # Query para pegar os espetaculos que tem data e organizar por ordem de apresentacao mais proxima
            espetaculos = Espetaculo.find(:all,
                                          :select => 'espetaculos.*, min(horarios.data)',
                                          :conditions => ["#{cond} AND horarios.data >= ?", DateTime.now],
                                          :joins => ["INNER JOIN horarios ON horarios.espetaculo_id = espetaculos.id",
                                                     "INNER JOIN teatros ON teatros.id = espetaculos.teatro_id",
                                                     "INNER JOIN cidades ON teatros.cidade_id = cidades.id AND cidades.id = #{@pecidade.id}",
                                                     "INNER JOIN espetaculos_pagina_especiais ON espetaculos.id = espetaculos_pagina_especiais.espetaculo_id AND espetaculos_pagina_especiais.pagina_especial_id = #{@pagina_especial.id}",
                                                     @innerjoin],
                                          :group => "horarios.espetaculo_id",
                                          :order => order)
            # Adiciona os espetaculos ao hash de espetaculos
            espetaculos.each do |e|
              @espetaculos << e
              ids << ",#{e.id}"
            end
            
            # Requesta os espetaculos que não tem data definida e os organiza por data exibindo por ultimo na listagem de espetaculos
            espetaculos = Espetaculo.find(:all,
                                          :select => 'espetaculos.*',
                                          :conditions => ["#{cond} AND espetaculos.id NOT IN (#{ids})"],
                                          :joins => ["INNER JOIN teatros ON teatros.id = espetaculos.teatro_id",
                                                     "INNER JOIN cidades ON teatros.cidade_id = cidades.id AND cidades.id = #{@pecidade.id}",
                                                     "INNER JOIN espetaculos_pagina_especiais ON espetaculos.id = espetaculos_pagina_especiais.espetaculo_id AND espetaculos_pagina_especiais.pagina_especial_id = #{@pagina_especial.id}",
                                                     @innerjoin],
                                          :order => 'espetaculos.relevancia DESC, espetaculos.nome ASC')
            # Adiciona os espetaculos ao hash de espetaculos
            espetaculos.each do |e|
              @espetaculos << e
            end
          end
          
        end
  
  
  
      # Caso nao tenha cidade mas tenha genero
      elsif (pcidade.blank? and !pgenero.blank?)
        @pegenero = Genero.find_by_nome(pgenero)
        if @pegenero
          
          # Caso não seja ordenado por data
          if (params[:ordem].blank? and @pagina_especial.organizado_por!=3) or (params[:ordem]!='data' and @pagina_especial.organizado_por!=3)
            @espetaculos = Espetaculo.find(:all,
                                           :conditions => ["#{cond} AND espetaculos.genero_id = ?", @pegenero.id],
                                           :joins => ["INNER JOIN espetaculos_pagina_especiais ON espetaculos.id = espetaculos_pagina_especiais.espetaculo_id AND espetaculos_pagina_especiais.pagina_especial_id = #{@pagina_especial.id}",
                                                      @innerjoin],
                                           :order => order)
            
          # Caso seja ordenado por data
          else
            @espetaculos = []
            ids = "0"
            # Query para pegar os espetaculos que tem data e organizar por ordem de apresentacao mais proxima
            espetaculos = Espetaculo.find(:all,
                                          :select => 'espetaculos.*, min(horarios.data)',
                                          :conditions => ["#{cond} AND horarios.data >= ? AND espetaculos.genero_id = ?", DateTime.now, @pegenero.id],
                                          :joins => ["INNER JOIN horarios ON horarios.espetaculo_id = espetaculos.id",
                                                     "INNER JOIN espetaculos_pagina_especiais ON espetaculos.id = espetaculos_pagina_especiais.espetaculo_id AND espetaculos_pagina_especiais.pagina_especial_id = #{@pagina_especial.id}",
                                                     @innerjoin],
                                          :group => "horarios.espetaculo_id",
                                          :order => order)
            # Adiciona os espetaculos ao hash de espetaculos
            espetaculos.each do |e|
              @espetaculos << e
              ids << ",#{e.id}"
            end
            
            # Requesta os espetaculos que não tem data definida e os organiza por data exibindo por ultimo na listagem de espetaculos
            espetaculos = Espetaculo.find(:all,
                                          :select => 'espetaculos.*',
                                          :conditions => ["#{cond} AND espetaculos.id NOT IN (#{ids}) AND espetaculos.genero_id = ?", @pegenero.id],
                                          :joins => ["INNER JOIN espetaculos_pagina_especiais ON espetaculos.id = espetaculos_pagina_especiais.espetaculo_id AND espetaculos_pagina_especiais.pagina_especial_id = #{@pagina_especial.id}",
                                                     @innerjoin],
                                          :order => 'espetaculos.relevancia DESC, espetaculos.nome ASC')
            # Adiciona os espetaculos ao hash de espetaculos
            espetaculos.each do |e|
              @espetaculos << e
            end
            
          end
        end
  
  
  
      # Caso tenha cidade e genero
      elsif (!pcidade.blank? and !pgenero.blank?)
        @pecidade = Cidade.find_by_nome(pcidade) # Pega o id da cidade para colocar na query de espetaculos
        @pegenero = Genero.find_by_nome(pgenero) # Pega o id do genero para colocar na query de espetaculos
        if @pecidade and @pegenero
          
          # Caso não seja ordenado por data
          if (params[:ordem].blank? and @pagina_especial.organizado_por!=3) or (params[:ordem]!='data' and @pagina_especial.organizado_por!=3)
            @espetaculos = Espetaculo.find(:all, 
                                           :conditions => {:ativo => true, :genero_id => @pegenero.id},
                                           :joins => ["INNER JOIN teatros ON teatros.id = espetaculos.teatro_id",
                                                      "INNER JOIN cidades ON cidades.id = teatros.cidade_id AND cidades.id = #{@pecidade.id.to_s}",
                                                      "INNER JOIN espetaculos_pagina_especiais ON espetaculos.id = espetaculos_pagina_especiais.espetaculo_id AND espetaculos_pagina_especiais.pagina_especial_id = #{@pagina_especial.id}",
                                                      @innerjoin],
                                           :order => order)
                                           
          # Caso seja ordenado por data
          else
            @espetaculos = []
            ids = "0"
            # Query para pegar os espetaculos que tem data e organizar por ordem de apresentacao mais proxima
            espetaculos = Espetaculo.find(:all,
                                          :select => 'espetaculos.*, min(horarios.data)',
                                          :conditions => ["#{cond} AND horarios.data >= ? AND espetaculos.genero_id = ?", DateTime.now, @pegenero.id],
                                          :joins => ["INNER JOIN horarios ON horarios.espetaculo_id = espetaculos.id",
                                                     "INNER JOIN teatros ON teatros.id = espetaculos.teatro_id",
                                                     "INNER JOIN cidades ON cidades.id = teatros.cidade_id AND cidades.id = #{@pecidade.id.to_s}",
                                                     "INNER JOIN espetaculos_pagina_especiais ON espetaculos.id = espetaculos_pagina_especiais.espetaculo_id AND espetaculos_pagina_especiais.pagina_especial_id = #{@pagina_especial.id}",
                                                     @innerjoin],
                                          :group => "horarios.espetaculo_id",
                                          :order => order)
            # Adiciona os espetaculos ao hash de espetaculos
            espetaculos.each do |e|
              @espetaculos << e
              ids << ",#{e.id}"
            end
            
            # Requesta os espetaculos que não tem data definida e os organiza por data exibindo por ultimo na listagem de espetaculos
            espetaculos = Espetaculo.find(:all,
                                          :select => 'espetaculos.*',
                                          :conditions => ["#{cond} AND espetaculos.id NOT IN (#{ids}) AND espetaculos.genero_id = ?", @pegenero.id],
                                          :joins => ["INNER JOIN teatros ON teatros.id = espetaculos.teatro_id",
                                                     "INNER JOIN cidades ON cidades.id = teatros.cidade_id AND cidades.id = #{@pecidade.id.to_s}",
                                                     "INNER JOIN espetaculos_pagina_especiais ON espetaculos.id = espetaculos_pagina_especiais.espetaculo_id AND espetaculos_pagina_especiais.pagina_especial_id = #{@pagina_especial.id}",
                                                     @innerjoin],
                                          :order => 'espetaculos.relevancia DESC, espetaculos.nome ASC')
            # Adiciona os espetaculos ao hash de espetaculos
            espetaculos.each do |e|
              @espetaculos << e
            end
          end
          
        end
        
      # Caso não tenha cidade nem genero e não seja uma busca de texto
      elsif params[:busca].blank?
        
        # Caso não seja ordenado por data
        if (params[:ordem].blank? and @pagina_especial.organizado_por!=3) or (params[:ordem]!='data' and @pagina_especial.organizado_por!=3)
          @espetaculos = Espetaculo.find(:all,
                                         :conditions => [cond],
                                         :joins => ["INNER JOIN espetaculos_pagina_especiais ON espetaculos.id = espetaculos_pagina_especiais.espetaculo_id AND espetaculos_pagina_especiais.pagina_especial_id = #{@pagina_especial.id}",
                                                    @innerjoin],
                                         :order => order)
          
        # Caso seja ordenado por data
        else
          @espetaculos = []
          ids = "0"
          # Query para pegar os espetaculos que tem data e organizar por ordem de apresentacao mais proxima
          espetaculos = Espetaculo.find(:all,
                                        :select => 'espetaculos.*, min(horarios.data)',
                                        :conditions => ["#{cond} AND horarios.data >= ?", DateTime.now],
                                        :joins => ["INNER JOIN horarios ON horarios.espetaculo_id = espetaculos.id",
                                                   "INNER JOIN espetaculos_pagina_especiais ON espetaculos.id = espetaculos_pagina_especiais.espetaculo_id AND espetaculos_pagina_especiais.pagina_especial_id = #{@pagina_especial.id}",
                                                   @innerjoin],
                                        :group => "horarios.espetaculo_id",
                                        :order => order)
          # Adiciona os espetaculos ao hash de espetaculos
          espetaculos.each do |e|
            @espetaculos << e
            ids << ",#{e.id}"
          end
          
          # Requesta os espetaculos que não tem data definida e os organiza por data exibindo por ultimo na listagem de espetaculos
          espetaculos = Espetaculo.find(:all,
                                        :conditions => ["#{cond} AND espetaculos.id NOT IN (#{ids})"],
                                        :joins => ["INNER JOIN espetaculos_pagina_especiais ON espetaculos.id = espetaculos_pagina_especiais.espetaculo_id AND espetaculos_pagina_especiais.pagina_especial_id = #{@pagina_especial.id}",
                                                   @innerjoin],
                                        :order => 'espetaculos.relevancia DESC, espetaculos.nome ASC')
          # Adiciona os espetaculos ao hash de espetaculos
          espetaculos.each do |e|
            @espetaculos << e
          end
        end
      end
      
      if !params[:busca].blank?
        busca = params[:busca].first(50) if params[:busca]!='Nome da peça, teatro, local, elenco...'
        @espetaculos = Espetaculo.search busca,
        :field_weights => {:nome => 100, :genero =>80, :teatro_nome => 80, :cidade => 70, :estado => 70, :keywords => 70, :endereco => 50, :bairro => 50, :entradas => 30},
        :match_mode => :any,
        :sort_mode => :extended,
        :joins => ["INNER JOIN espetaculos_pagina_especiais ON espetaculos.id = espetaculos_pagina_especiais.espetaculo_id AND espetaculos_pagina_especiais.pagina_especial_id = #{@pagina_especial.id}",
                   @innerjoin],
        :order => "@relevance DESC",
        :index => "privado",
        :per_page => 1000
        
        x = []
        @espetaculos.each do |e|
          unless e.nil?
            x << e
          end
        end
        @espetaculos = x
      end
    end
    
    if @pagina_especial.url=="itaucardshows" or @pagina_especial.url=="itaucardteatro"
    #if @pagina_especial.url=="itaucard"
      @m1 = []
      @m2 = []
      @m3 = []
      @m4 = []
      d1a = Date.today.beginning_of_month
      d1b = Date.today.end_of_month
      d2a = (Date.today+1.month).beginning_of_month
      d2b = (Date.today+1.month).end_of_month
      d3a = (Date.today+2.month).beginning_of_month
      d3b = (Date.today+2.month).end_of_month
      @espetaculos.each do |e|
        if defined?(e.proximo_horario) and e.proximo_horario and e.proximo_horario.data
          if e.proximo_horario.data >= d1a and e.proximo_horario.data <= d1b
            @m1 << e
          elsif e.proximo_horario.data >= d2a and e.proximo_horario.data <= d2b
            @m2 << e
          elsif e.proximo_horario.data >= d3a and e.proximo_horario.data <= d3b
            @m3 << e
          else
            @m4 << e
          end
        end
      end
    end
    
    respond_to do |format|
      # Caso não exista a pagina requisitada
      if @pagina_especial.nil?
        format.html { render :layout => 'compreingressos', :action => 'pagina_off' }
      else
        # Caso seja a pagina de uma turne o layout é diferente
        if @pagina_especial.tipo == 3
          format.html { render :layout => 'compreingressos', :action => 'show_turne' }
          format.json if params[:key] == Espetaculo::KEY_TOKECOMPRE_APP # Para visualizar o json URL /pagina_especiais/show.json?url=itaucard&key=8435D5115e46a70i6648715850882eus
        else
          if @pagina_especial.id==49 and params[:filtro].blank?
            format.html { render :layout => 'compreingressos', :action => 'unibescultural' }
          elsif @pagina_especial.url=="itaucardshows" or @pagina_especial.url=="itaucardteatro"
            format.html { render :layout => 'compreingressos', :action => 'itaucard' }
          elsif @pagina_especial.url=="itaucard"
            format.html { render :layout => 'compreingressos', :action => 'itaucard-selecionar-tipo' }
          #elsif @pagina_especial.url=="itaucard"
          #  format.html { render :layout => 'compreingressos', :action => 'itaucard' }
          else
            format.html { render :layout => 'compreingressos', :action => 'show' }
            format.json if params[:key] == Espetaculo::KEY_TOKECOMPRE_APP # Para visualizar o json URL /pagina_especiais/show.json?url=itaucard&key=8435D5115e46a70i6648715850882eus
          end
        end
      end
    end
  end

  # GET /pagina_especiais/new
  # GET /pagina_especiais/new.xml
  def new
    @pagina_especial = PaginaEspecial.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pagina_especial }
    end
  end

  # GET /pagina_especiais/1/edit
  def edit
    if !params[:id].blank?
      @pagina_especial = PaginaEspecial.find(params[:id])
    elsif !params[:url].blank?
      @pagina_especial = PaginaEspecial.find_by_url(params[:url])
    end
  end

  # POST /pagina_especiais
  # POST /pagina_especiais.xml
  def create
    @pagina_especial = PaginaEspecial.new(params[:pagina_especial])

    respond_to do |format|
      if @pagina_especial.save
        format.html { redirect_to("/pagina_especiais/selecionar/#{@pagina_especial.id}") }
        format.xml  { render :xml => @pagina_especial, :status => :created, :location => @pagina_especial }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pagina_especial.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pagina_especiais/1
  # PUT /pagina_especiais/1.xml
  def update
    @pagina_especial = PaginaEspecial.find(params[:id])

    respond_to do |format|
      if @pagina_especial.update_attributes(params[:pagina_especial])
        format.html { redirect_to("/#{@pagina_especial.url}") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pagina_especial.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pagina_especiais/1
  # DELETE /pagina_especiais/1.xml
  def destroy
    @pagina_especial = PaginaEspecial.find(params[:id])
    @pagina_especial.destroy

    respond_to do |format|
      format.html { redirect_to(pagina_especiais_url) }
      format.xml  { head :ok }
    end
  end
  
  def selecionar
    @pagina_especial = PaginaEspecial.find(params[:id])
    # Verifica se seleciona somente espetaculos marcados como privados ou não
    if @pagina_especial.tipo == 2
      @espetaculos = Espetaculo.find(:all, :include => :teatro, :conditions => ["espetaculos.ativo = 1 OR espetaculos.privado = 1"], :order => :nome)
      #@espetaculos = @pagina_especial.espetaculos.find(:all, :order => 'espetaculos.nome ASC')
    else
      @espetaculos = Espetaculo.find(:all, :include => :teatro, :conditions => {:ativo => true}, :order => :nome)      
    end
  end
  
  def excluir_img
    @pagina_especial = PaginaEspecial.find(params[:id])
    if params[:tipo]=='imagem'
      @pagina_especial.imagem.clear
    end
    @pagina_especial.save
    redirect_to(edit_pagina_especial_path(@pagina_especial))
  end

=begin
  def setaalturadeiniciomobile
    paginaespecial = PaginaEspecial.find(:all, :conditions => ["altura_de_inicio_da_listagem IS NOT NULL"])
    paginaespecial.each do |pe|
      a = pe.altura_de_inicio_da_listagem/3
      pe.altura_de_inicio_da_listagem_mobile = a.round()
      pe.save
    end
    render :text => "#### SUCESSO ####"
  end
=end
end