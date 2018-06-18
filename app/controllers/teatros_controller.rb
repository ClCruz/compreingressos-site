class TeatrosController < ApplicationController
  before_filter :authorize, :except => [:index, :show]
  newrelic_ignore :except => [:index, :show]

  layout 'compreingressos_antigo'
  
  # GET /teatros
  # GET /teatros.xml
  def admin_index
    @teatros = Teatro.find(:all, :order => :nome)
  end
  
  def index
    if params[:ordem].blank?
      order = 'teatros.relevancia DESC, teatros.nome ASC'
    else
      order = 'teatros.nome ASC'
    end

    @cid = Cidade.find_by_sql('SELECT count(1) as total, c.nome FROM cidades as c, teatros as t WHERE c.id = t.cidade_id AND t.id IN (SELECT e.teatro_id FROM espetaculos AS e WHERE e.ativo = 1) GROUP BY c.id ORDER BY total DESC')
    if params[:teatro_cidade].blank? or params[:teatro_cidade] == "Todas"
      @tea = Teatro.find(:all, :include => [:espetaculos], :conditions => ['espetaculos.ativo = 1'], :order => order)
    else
      @cidade = Cidade.find_by_nome(params[:teatro_cidade])
      if @cidade
        @tea = @cidade.teatros.find(:all, :select => ['teatros.nome'], :include => [:espetaculos], :conditions => ['espetaculos.ativo = 1'], :order => order)
      else
        @tea = Teatro.find(:all, :include => [:espetaculos], :conditions => ['espetaculos.ativo = 1'], :order => order)
      end
    end
    @title = "Teatros"
    
    respond_to do |format|
      format.html { render :layout => 'compreingressos'}
      format.xml  { render :xml => @teatros }
    end
  end

  # GET /teatros/1
  # GET /teatros/1.xml
  def show
    @tea = Teatro.find(params[:id])
    # Trata a ordem de exibicao dos espetaculos
    if @tea.ordenacao_dos_espetaculos==3
      @espetaculos_cartaz = @tea.espetaculos.find(:all,
												  :select => 'espetaculos.*, min(horarios.data)',
                                                  :conditions => ["espetaculos.ativo = 1 AND horarios.data >= ?", DateTime.now],
                                                  :joins => ["INNER JOIN horarios ON horarios.espetaculo_id = espetaculos.id"],
                                                  :group => :espetaculo_id,
                                                  :order => 'min(horarios.data) ASC, espetaculos.relevancia DESC, espetaculos.nome ASC')
    else
      if @tea.ordenacao_dos_espetaculos==1
        order = "relevancia DESC"
      elsif @tea.ordenacao_dos_espetaculos==2
        order = "nome ASC"
      end
      @espetaculos_cartaz = @tea.espetaculos.find(:all, :conditions => {:ativo => true}, :order => order)
    end
    
    @title = @tea.nome
    @keywords = @tea.keywords
    @description = @tea.description
    @imagem = ENVIRONMENT_VARS['host']+@tea.imagem.url(:big)
    @tea.ocultar_teatro = true
    @tea.ocultar_cidade = true
    @tea.ocultar_genero = false
    
    # Conta visitas
    #sql = "UPDATE teatros SET visitas = visitas+1 WHERE id = #{@tea.id};"
    #ActiveRecord::Base.connection.execute(sql)
    
    respond_to do |format|
      format.html { render :layout => 'compreingressos' }
      format.xml  { render :xml => @tea }
    end
  end

  # GET /teatros/new
  # GET /teatros/new.xml
  def new
    @teatro = Teatro.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @teatro }
    end
  end

  # GET /teatros/1/edit
  def edit
    @teatro = Teatro.find(params[:id])
  end

  # POST /teatros
  # POST /teatros.xml
  def create
    @teatro = Teatro.new(params[:teatro])

    respond_to do |format|
      if @teatro.save
        flash[:notice] = 'Teatro was successfully created.'
        format.html { redirect_to(@teatro) }
        format.xml  { render :xml => @teatro, :status => :created, :location => @teatro }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @teatro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /teatros/1
  # PUT /teatros/1.xml
  def update
    @teatro = Teatro.find(params[:id])

    respond_to do |format|
      if @teatro.update_attributes(params[:teatro])
        flash[:notice] = 'Teatro was successfully updated.'
        format.html { redirect_to(@teatro) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @teatro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /teatros/1
  # DELETE /teatros/1.xml
  def destroy
    @teatro = Teatro.find(params[:id])
    @teatro.destroy

    respond_to do |format|
      format.html { redirect_to(teatros_url) }
      format.xml  { head :ok }
    end
  end
  
  def resize
    # LINK DA URL PARA CONVERSAO
    # http://localhost:3000/teatros/resize?i=200&f=100
    # A partir do teatro 200 pegar os proximos 100
    nc = []
    nu = []
    tu = []
    @teatros = Teatro.find(:all, :order => :id, :limit => params[:f], :offset => params[:i])
    @teatros.each do |t|
      if t.imagems.size >= 2 and 1==0
        if t.imagems.size > 2 and t.imagems[2].respond_to?('id')
          imagem = File.open("#{RAILS_ROOT}/public/cache/#{t.imagems[2].id.to_s}_destaque.jpg")
          teatro = {:imagem => imagem}
          if t.update_attributes(teatro)
            tu << t.id
          else
            nu << t.id
          end
          logger.info("#################")
          logger.info(t.errors.full_messages.to_sentence)
        end
      else
        nc << t.id
      end
    end
    logger.info("#################")
    logger.info("Não convertidos: 0#{nc.collect{|v| ", #{v}"}.join}")
    logger.info("Não atualizados: 0#{nu.collect{|v| ", #{v}"}.join}")
    logger.info("#################")
    logger.info("Atualizados: 0#{tu.collect{|v| ", #{v}"}.join}")
    logger.info("#################")
    render :text => "#### SUCESSO #### <br /><br />Started in: #{params[:i]} (ID: #{@teatros.first.id})<br />Ended in: #{params[:f].to_i+params[:i].to_i-1} (ID: #{@teatros.last.id})"
  end
  
#  def address_lat_long
#    teatros = Teatro.find(:all, :conditions => ["latitude IS NULL"])
#    ta = 0
#    te = 0
#    teatros.each do |t|
#      if t.save
#        ta = ta+1
#      else
#        te = te+1
#      end
#    end
#    render :text => "Alterados: #{ta} <br />Erros: #{te}"
#  end
end
