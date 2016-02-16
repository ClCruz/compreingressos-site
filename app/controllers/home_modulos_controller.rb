class HomeModulosController < ApplicationController
  before_filter :authorize
  newrelic_ignore_apdex
  layout 'compreingressos_antigo'
  
  # GET /home_modulos
  # GET /home_modulos.xml
  def index
    @home_modulos = HomeModulo.all(:order => :ordem)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @home_modulos }
    end
  end

  # GET /home_modulos/1
  # GET /home_modulos/1.xml
  def show
    @home_modulo = HomeModulo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @home_modulo }
    end
  end

  # GET /home_modulos/new
  # GET /home_modulos/new.xml
  def new
    @home_modulo = HomeModulo.new
    @espetaculos = Espetaculo.find(:all, :conditions => { :ativo => true }, :order => 'nome').map{|e| ["#{e.nome.gsub('"',"'")} (#{e.teatro.nome})",e.id]}

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @home_modulo }
    end
  end

  # GET /home_modulos/1/edit
  def edit
    @home_modulo = HomeModulo.find(params[:id])
    @espetaculos = Espetaculo.find(:all, :conditions => { :ativo => true }, :order => 'nome').map{|e| ["#{e.nome.gsub('"',"'")} (#{e.teatro.nome})",e.id]}
  end

  # POST /home_modulos
  # POST /home_modulos.xml
  def create
    @home_modulo = HomeModulo.new(params[:home_modulo])

    respond_to do |format|
      if @home_modulo.save
        format.html { redirect_to(edit_home_modulo_path(@home_modulo), :notice => 'HomeModulo was successfully created.') }
        format.xml  { render :xml => @home_modulo, :status => :created, :location => @home_modulo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @home_modulo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /home_modulos/1
  # PUT /home_modulos/1.xml
  def update
    @home_modulo = HomeModulo.find(params[:id])

    respond_to do |format|
      if @home_modulo.update_attributes(params[:home_modulo])
        format.html { redirect_to('/home_modulos#modulo_'+@home_modulo.id.to_s, :notice => 'HomeModulo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @home_modulo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /home_modulos/1
  # DELETE /home_modulos/1.xml
  def destroy
    @home_modulo = HomeModulo.find(params[:id])
    @home_modulo.destroy

    respond_to do |format|
      format.html { redirect_to(home_modulos_url) }
      format.xml  { head :ok }
    end
  end

  def reorganiza
    begin
      params[:modulo].each_with_index do |id, i|
        obj = HomeModulo.find(:first, :conditions => {:id => id})
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
