class PublicidadesController < ApplicationController
  before_filter :authorize
  newrelic_ignore
  layout 'compreingressos_antigo'
  
  # GET /publicidades
  # GET /publicidades.xml
  def index
    @publicidades = Publicidade.find(:all, :order => "data_inicio, data_fim, nome")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @publicidades }
    end
  end

  # GET /publicidades/1
  # GET /publicidades/1.xml
  def show
    @publicidade = Publicidade.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @publicidade }
    end
  end

  # GET /publicidades/new
  # GET /publicidades/new.xml
  def new
    @publicidade = Publicidade.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @publicidade }
    end
  end

  # GET /publicidades/1/edit
  def edit
    @publicidade = Publicidade.find(params[:id])
  end

  # POST /publicidades
  # POST /publicidades.xml
  def create
    @publicidade = Publicidade.new(params[:publicidade])

    respond_to do |format|
      if @publicidade.save
        format.html { redirect_to(publicidades_url, :notice => 'Publicidade was successfully created.') }
        format.xml  { render :xml => @publicidade, :status => :created, :location => @publicidade }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @publicidade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /publicidades/1
  # PUT /publicidades/1.xml
  def update
    @publicidade = Publicidade.find(params[:id])

    respond_to do |format|
      if @publicidade.update_attributes(params[:publicidade])
        format.html { redirect_to(publicidades_url, :notice => 'Publicidade was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @publicidade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /publicidades/1
  # DELETE /publicidades/1.xml
  def destroy
    @publicidade = Publicidade.find(params[:id])
    @publicidade.destroy

    respond_to do |format|
      format.html { redirect_to(publicidades_url) }
      format.xml  { head :ok }
    end
  end
end
