class CidadeVisoresController < ApplicationController
  before_filter :authorize
  newrelic_ignore_apdex
  
  # GET /cidade_visores
  # GET /cidade_visores.xml
  def index
    @cidade_visores = CidadeVisor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cidade_visores }
    end
  end

  # GET /cidade_visores/1
  # GET /cidade_visores/1.xml
  def show
    @cidade_visor = CidadeVisor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cidade_visor }
    end
  end

  # GET /cidade_visores/new
  # GET /cidade_visores/new.xml
  def new
    @cidade_visor = CidadeVisor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cidade_visor }
    end
  end

  # GET /cidade_visores/1/edit
  def edit
    @cidade_visor = CidadeVisor.find(params[:id])
  end

  # POST /cidade_visores
  # POST /cidade_visores.xml
  def create
    @cidade_visor = CidadeVisor.new(params[:cidade_visor])

    respond_to do |format|
      if @cidade_visor.save
        format.html { redirect_to(@cidade_visor, :notice => 'CidadeVisor was successfully created.') }
        format.xml  { render :xml => @cidade_visor, :status => :created, :location => @cidade_visor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cidade_visor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cidade_visores/1
  # PUT /cidade_visores/1.xml
  def update
    @cidade_visor = CidadeVisor.find(params[:id])

    respond_to do |format|
      if @cidade_visor.update_attributes(params[:cidade_visor])
        format.html { redirect_to(@cidade_visor, :notice => 'CidadeVisor was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cidade_visor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cidade_visores/1
  # DELETE /cidade_visores/1.xml
  def destroy
    @cidade_visor = CidadeVisor.find(params[:id])
    @cidade_visor.destroy

    respond_to do |format|
      format.html { redirect_to(cidade_visores_url) }
      format.xml  { head :ok }
    end
  end

  def reorganiza
    begin
      params[:cidade_visor].each_with_index do |id, i|
        obj = CidadeVisor.find(:first, :conditions => {:id => id, :cidade_id => params[:cidade_id]})
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
