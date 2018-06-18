class PaginaDePacotesController < ApplicationController
  before_filter :authorize, :except => [:index]
  newrelic_ignore :except => [:index]
  layout 'compreingressos_antigo'
  
  # GET /pagina_de_pacotes
  # GET /pagina_de_pacotes.xml
  def admin_index
    @pagina_de_pacotes = PaginaDePacote.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pagina_de_pacotes }
    end
  end
  
  def index
    @pagina_de_pacotes = PaginaDePacote.find(:first, :conditions => {:url => params[:url]})

    respond_to do |format|
      if params[:filtro].blank? and @pagina_de_pacotes.url == 'theatromunicipaldesaopaulo'
        format.html { render :layout => 'compreingressos', :action => 'theatromunicipaldesp' }
      elsif params[:filtro].blank? and @pagina_de_pacotes.url == 'saladoconservatorio'
        format.html { render :layout => 'compreingressos', :action => 'saladoconservatorio' }
      else
        @pacotes = Pacote.find(:all,
                               :joins => ["INNER JOIN pacote_filtros ON pacote_filtros.url = '#{params[:filtro]}'",
                                      "INNER JOIN pacote_filtros_pacotes ON pacotes.id = pacote_filtros_pacotes.pacote_id and pacote_filtros_pacotes.pacote_filtro_id = pacote_filtros.id "],
                               :order => :ordem)
        format.html { render :layout => 'compreingressos', :action => 'index' }
      end
    end
  end

  # GET /pagina_de_pacotes/1
  # GET /pagina_de_pacotes/1.xml
  def show
    @pagina_de_pacote = PaginaDePacote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pagina_de_pacote }
    end
  end

  # GET /pagina_de_pacotes/new
  # GET /pagina_de_pacotes/new.xml
  def new
    @pagina_de_pacote = PaginaDePacote.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pagina_de_pacote }
    end
  end

  # GET /pagina_de_pacotes/1/edit
  def edit
    @pagina_de_pacote = PaginaDePacote.find(params[:id])
  end

  # POST /pagina_de_pacotes
  # POST /pagina_de_pacotes.xml
  def create
    @pagina_de_pacote = PaginaDePacote.new(params[:pagina_de_pacote])

    respond_to do |format|
      if @pagina_de_pacote.save
        format.html { redirect_to("/pacotes?id=#{@pagina_de_pacote.id}") }
        format.xml  { render :xml => @pagina_de_pacote, :status => :created, :location => @pagina_de_pacote }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pagina_de_pacote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pagina_de_pacotes/1
  # PUT /pagina_de_pacotes/1.xml
  def update
    @pagina_de_pacote = PaginaDePacote.find(params[:id])
    
    respond_to do |format|
      if @pagina_de_pacote.update_attributes(params[:pagina_de_pacote])
        format.html { redirect_to("/#{@pagina_de_pacote.url}/assinaturas") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pagina_de_pacote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pagina_de_pacotes/1
  # DELETE /pagina_de_pacotes/1.xml
  def destroy
    @pagina_de_pacote = PaginaDePacote.find(params[:id])
    @pagina_de_pacote.destroy

    respond_to do |format|
      format.html { redirect_to(pagina_de_pacotes_url) }
      format.xml  { head :ok }
    end
  end
end
