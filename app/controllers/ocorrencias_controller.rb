class OcorrenciasController < ApplicationController
  before_filter :authorize
  newrelic_ignore_apdex
  before_filter :authorizeAtendente
  # GET /ocorrencias
  # GET /ocorrencias.xml
  def index
    if (@logged_atendente.nivel > 1)
      @ocorrencias = Ocorrencia.find(:all, :order => 'created_at DESC', :conditions => {:processada => false})
    else
      @ocorrencias = Ocorrencia.find(:all, :order => 'created_at DESC', :conditions => {:processada => false, :atendente_id => @logged_atendente.id})
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ocorrencias }
    end
  end
  
  def processadas
    if (@logged_atendente.nivel > 1)
      @ocorrencias = Ocorrencia.find(:all, :order => 'created_at DESC', :conditions => {:processada => true})
    else
      @ocorrencias = Ocorrencia.find(:all, :order => 'created_at DESC', :conditions => {:processada => true, :atendente_id => @logged_atendente.id})
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ocorrencias }
    end
  end

  # GET /ocorrencias/1
  # GET /ocorrencias/1.xml
  def show
    @ocorrencia = Ocorrencia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ocorrencia }
    end
  end

  # GET /ocorrencias/new
  # GET /ocorrencias/new.xml
  def new
    @ocorrencia = Ocorrencia.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ocorrencia }
    end
  end

  # GET /ocorrencias/1/edit
  def edit
    if (@logged_atendente.nivel < 2)
      flash[:notice] = "Você não está autorizado a editar ocorrências"
      redirect_to(:action => :index)
      return
    end
    @ocorrencia = Ocorrencia.find(params[:id])
  end

  # POST /ocorrencias
  # POST /ocorrencias.xml
  def create
    @ocorrencia = Ocorrencia.new(params[:ocorrencia])
    @ocorrencia.processada = false
    
    respond_to do |format|
      if @ocorrencia.save
        Emailer.deliver_ocorrencia(@ocorrencia)
        flash[:notice] = 'Ocorrencia was successfully created.'
        format.html { redirect_to(:action => :index) }
        format.xml  { render :xml => @ocorrencia, :status => :created, :location => @ocorrencia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ocorrencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ocorrencias/1
  # PUT /ocorrencias/1.xml
  def update
    if (@logged_atendente.nivel < 2)
      flash[:notice] = "Você não está autorizado a editar ocorrências"
      redirect_to(:action => :index)
      return
    end
    
    @ocorrencia = Ocorrencia.find(params[:id])

    respond_to do |format|
      if @ocorrencia.update_attributes(params[:ocorrencia])
        flash[:notice] = 'Ocorrencia was successfully updated.'
        format.html { redirect_to(:action => :index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ocorrencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ocorrencias/1
  # DELETE /ocorrencias/1.xml
  def destroy
    if (@logged_atendente.nivel < 2)
      flash[:notice] = "Você não está autorizado a editar ocorrências"
      redirect_to(:action => :index)
      return
    end
    
    @ocorrencia = Ocorrencia.find(params[:id])
    @ocorrencia.destroy

    respond_to do |format|
      format.html { redirect_to(ocorrencias_url) }
      format.xml  { head :ok }
    end
  end
end
