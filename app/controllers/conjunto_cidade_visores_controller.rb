class ConjuntoCidadeVisoresController < ApplicationController
  before_filter :authorize
  newrelic_ignore_apdex
  
  # GET /conjunto_cidade_visores
  # GET /conjunto_cidade_visores.xml
  def index
    @conjunto_cidade_visores = ConjuntoCidadeVisor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @conjunto_cidade_visores }
    end
  end

  # GET /conjunto_cidade_visores/1
  # GET /conjunto_cidade_visores/1.xml
  def show
    @conjunto_cidade_visor = ConjuntoCidadeVisor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @conjunto_cidade_visor }
    end
  end

  # GET /conjunto_cidade_visores/new
  # GET /conjunto_cidade_visores/new.xml
  def new
    @conjunto_cidade_visor = ConjuntoCidadeVisor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @conjunto_cidade_visor }
    end
  end

  # GET /conjunto_cidade_visores/1/edit
  def edit
    @conjunto_cidade_visor = ConjuntoCidadeVisor.find(params[:id])
  end

  # POST /conjunto_cidade_visores
  # POST /conjunto_cidade_visores.xml
  def create
    @conjunto_cidade_visor = ConjuntoCidadeVisor.new(params[:conjunto_cidade_visor])

    respond_to do |format|
      if @conjunto_cidade_visor.save
        format.html { redirect_to(@conjunto_cidade_visor, :notice => 'ConjuntoCidadeVisor was successfully created.') }
        format.xml  { render :xml => @conjunto_cidade_visor, :status => :created, :location => @conjunto_cidade_visor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @conjunto_cidade_visor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /conjunto_cidade_visores/1
  # PUT /conjunto_cidade_visores/1.xml
  def update
    @conjunto_cidade_visor = ConjuntoCidadeVisor.find(params[:id])

    respond_to do |format|
      if @conjunto_cidade_visor.update_attributes(params[:conjunto_cidade_visor])
        format.html { redirect_to(@conjunto_cidade_visor, :notice => 'ConjuntoCidadeVisor was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @conjunto_cidade_visor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /conjunto_cidade_visores/1
  # DELETE /conjunto_cidade_visores/1.xml
  def destroy
    @conjunto_cidade_visor = ConjuntoCidadeVisor.find(params[:id])
    @conjunto_cidade_visor.destroy

    respond_to do |format|
      format.html { redirect_to(conjunto_cidade_visores_url) }
      format.xml  { head :ok }
    end
  end

  def reorganiza
    begin
      params[:conjunto_cidade_visor].each_with_index do |id, i|
        obj = ConjuntoCidadeVisor.find(:first, :conditions => {:id => id, :conjunto_cidade_id => params[:conjunto_cidade_id]})
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
