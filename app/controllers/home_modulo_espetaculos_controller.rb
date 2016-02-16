class HomeModuloEspetaculosController < ApplicationController
  before_filter :authorize
  newrelic_ignore_apdex
  layout 'compreingressos_antigo'
  
  # GET /home_modulo_espetaculos
  # GET /home_modulo_espetaculos.xml
  def index
    @home_modulo_espetaculos = HomeModuloEspetaculo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @home_modulo_espetaculos }
    end
  end

  # GET /home_modulo_espetaculos/1
  # GET /home_modulo_espetaculos/1.xml
  def show
    @home_modulo_espetaculo = HomeModuloEspetaculo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @home_modulo_espetaculo }
    end
  end

  # GET /home_modulo_espetaculos/new
  # GET /home_modulo_espetaculos/new.xml
  def new
    @home_modulo_espetaculo = HomeModuloEspetaculo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @home_modulo_espetaculo }
    end
  end

  # GET /home_modulo_espetaculos/1/edit
  def edit
    @home_modulo_espetaculo = HomeModuloEspetaculo.find(params[:id])
  end

  # POST /home_modulo_espetaculos
  # POST /home_modulo_espetaculos.xml
  def create
    @home_modulo_espetaculo = HomeModuloEspetaculo.new(params[:home_modulo_espetaculo])

    respond_to do |format|
      if @home_modulo_espetaculo.save
        format.html { redirect_to(edit_home_modulo_path(@home_modulo_espetaculo.home_modulo_id), :notice => 'HomeModuloEspetaculo was successfully created.') }
        format.xml  { render :xml => @home_modulo_espetaculo, :status => :created, :location => @home_modulo_espetaculo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @home_modulo_espetaculo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /home_modulo_espetaculos/1
  # PUT /home_modulo_espetaculos/1.xml
  def update
    @home_modulo_espetaculo = HomeModuloEspetaculo.find(params[:id])

    respond_to do |format|
      if @home_modulo_espetaculo.update_attributes(params[:home_modulo_espetaculo])
        format.html { redirect_to(@home_modulo_espetaculo, :notice => 'HomeModuloEspetaculo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @home_modulo_espetaculo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /home_modulo_espetaculos/1
  # DELETE /home_modulo_espetaculos/1.xml
  def destroy
    @home_modulo_espetaculo = HomeModuloEspetaculo.find(params[:id])
    @home_modulo_espetaculo.destroy

    respond_to do |format|
      format.html { redirect_to(home_modulo_espetaculos_url) }
      format.xml  { head :ok }
    end
  end

  def reorganiza
    begin
      params[:home_modulo_espetaculo].each_with_index do |id, i|
        obj = HomeModuloEspetaculo.find(:first, :conditions => {:id => id})
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
