class PaginaEspecialVisoresController < ApplicationController
  before_filter :authorize

  # GET /pagina_especial_visores
  # GET /pagina_especial_visores.xml
  def index
    @pagina_especial_visores = PaginaEspecialVisor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pagina_especial_visores }
    end
  end

  # GET /pagina_especial_visores/1
  # GET /pagina_especial_visores/1.xml
  def show
    @pagina_especial_visor = PaginaEspecialVisor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pagina_especial_visor }
    end
  end

  # GET /pagina_especial_visores/new
  # GET /pagina_especial_visores/new.xml
  def new
    @pagina_especial_visor = PaginaEspecialVisor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pagina_especial_visor }
    end
  end

  # GET /pagina_especial_visores/1/edit
  def edit
    @pagina_especial_visor = PaginaEspecialVisor.find(params[:id])
  end

  # POST /pagina_especial_visores
  # POST /pagina_especial_visores.xml
  def create
    @pagina_especial_visor = PaginaEspecialVisor.new(params[:pagina_especial_visor])

    respond_to do |format|
      if @pagina_especial_visor.save
        format.html { redirect_to(@pagina_especial_visor, :notice => 'PaginaEspecialVisor was successfully created.') }
        format.xml  { render :xml => @pagina_especial_visor, :status => :created, :location => @pagina_especial_visor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pagina_especial_visor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pagina_especial_visores/1
  # PUT /pagina_especial_visores/1.xml
  def update
    @pagina_especial_visor = PaginaEspecialVisor.find(params[:id])

    respond_to do |format|
      if @pagina_especial_visor.update_attributes(params[:pagina_especial_visor])
        format.html { redirect_to(@pagina_especial_visor, :notice => 'PaginaEspecialVisor was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pagina_especial_visor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pagina_especial_visores/1
  # DELETE /pagina_especial_visores/1.xml
  def destroy
    @pagina_especial_visor = PaginaEspecialVisor.find(params[:id])
    @pagina_especial_visor.destroy

    respond_to do |format|
      format.html { redirect_to(pagina_especial_visores_url) }
      format.xml  { head :ok }
    end
  end

  def reorganiza
    begin
      params[:pagina_especial_visor].each_with_index do |id, i|
        obj = PaginaEspecialVisor.find(:first, :conditions => {:id => id, :pagina_especial_id => params[:pagina_especial_id]})
        obj.ordem = i
        obj.save
      end
      text = 'true'
    rescue Exception => e
      text = e.message
    end
    respond_to do |format|
      format.html { render :text => text }
    end
  end
end
