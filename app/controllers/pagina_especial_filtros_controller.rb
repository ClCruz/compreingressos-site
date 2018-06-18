class PaginaEspecialFiltrosController < ApplicationController
  before_filter :authorize
  newrelic_ignore_apdex
  layout 'compreingressos_antigo'

  # GET /pagina_especial_filtros
  # GET /pagina_especial_filtros.xml
  def index
    @pagina_especial_filtros = PaginaEspecialFiltro.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pagina_especial_filtros }
    end
  end

  # GET /pagina_especial_filtros/1
  # GET /pagina_especial_filtros/1.xml
  def show
    @pagina_especial_filtro = PaginaEspecialFiltro.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pagina_especial_filtro }
    end
  end

  # GET /pagina_especial_filtros/new
  # GET /pagina_especial_filtros/new.xml
  def new
    @pagina_especial_filtro = PaginaEspecialFiltro.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pagina_especial_filtro }
    end
  end

  # GET /pagina_especial_filtros/1/edit
  def edit
    @pagina_especial_filtro = PaginaEspecialFiltro.find(params[:id])
  end

  # POST /pagina_especial_filtros
  # POST /pagina_especial_filtros.xml
  def create
    @pagina_especial_filtro = PaginaEspecialFiltro.new(params[:pagina_especial_filtro])

    respond_to do |format|
      if @pagina_especial_filtro.save
        format.html { redirect_to(pagina_especial_filtros_url) }
        format.xml  { render :xml => @pagina_especial_filtro, :status => :created, :location => @pagina_especial_filtro }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pagina_especial_filtro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pagina_especial_filtros/1
  # PUT /pagina_especial_filtros/1.xml
  def update
    @pagina_especial_filtro = PaginaEspecialFiltro.find(params[:id])

    respond_to do |format|
      if @pagina_especial_filtro.update_attributes(params[:pagina_especial_filtro])
        format.html { redirect_to(pagina_especial_filtros_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pagina_especial_filtro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pagina_especial_filtros/1
  # DELETE /pagina_especial_filtros/1.xml
  def destroy
    @pagina_especial_filtro = PaginaEspecialFiltro.find(params[:id])
    @pagina_especial_filtro.destroy

    respond_to do |format|
      format.html { redirect_to(pagina_especial_filtros_url) }
      format.xml  { head :ok }
    end
  end
end
