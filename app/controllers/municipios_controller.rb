class MunicipiosController < ApplicationController
  before_filter :authorize
  # GET /municipios
  # GET /municipios.xml
  def index
    cidade=params[:term]
    @municipios = Municipio.find(:all, 
                                  :select=>"municipios.id as value,municipios.nome as label, estados.sigla as sigla",
                                  :conditions=>"municipios.nome like '%#{cidade}%'",
                                  :joins=>"INNER JOIN estados ON estados.id=estado_id",
                                  :order=>"municipios.nome",
                                  :limit=> 10)
                                  
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @municipios }
    end
  end

  # GET /municipios/1
  # GET /municipios/1.xml
  def show
    @municipio = Municipio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @municipio }
    end
  end

  # GET /municipios/new
  # GET /municipios/new.xml
  def new
    @municipio = Municipio.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @municipio }
    end
  end

  # GET /municipios/1/edit
  def edit
    @municipio = Municipio.find(params[:id])
  end

  # POST /municipios
  # POST /municipios.xml
  def create
    @municipio = Municipio.new(params[:municipio])

    respond_to do |format|
      if @municipio.save
        format.html { redirect_to(@municipio, :notice => 'Municipio was successfully created.') }
        format.xml  { render :xml => @municipio, :status => :created, :location => @municipio }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @municipio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /municipios/1
  # PUT /municipios/1.xml
  def update
    @municipio = Municipio.find(params[:id])

    respond_to do |format|
      if @municipio.update_attributes(params[:municipio])
        format.html { redirect_to(@municipio, :notice => 'Municipio was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @municipio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /municipios/1
  # DELETE /municipios/1.xml
  def destroy
    @municipio = Municipio.find(params[:id])
    @municipio.destroy

    respond_to do |format|
      format.html { redirect_to(municipios_url) }
      format.xml  { head :ok }
    end
  end
end
