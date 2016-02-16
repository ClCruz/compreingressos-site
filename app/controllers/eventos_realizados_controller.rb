class EventosRealizadosController < ApplicationController
  before_filter :authorize, :except => [:index]
  newrelic_ignore :except => [:index]
  layout 'compreingressos_antigo'
  
  # GET /cidades
  # GET /cidades.xml
  def admin_index
    @er = EventosRealizados.find(:all, :order => :ordem)
  end
  
  
  def index
    @er = EventosRealizados.find(:all, :order => :ordem)

    respond_to do |format|
      format.html { render :layout => 'compreingressos' }
      format.xml  { render :xml => @er }
    end
  end

  # GET /cidades/new
  # GET /cidades/new.xml
  def new
    @er = EventosRealizados.new
    @espetaculos = Espetaculo.find(:all,
                                   :order => :nome,
                                   :joins => "INNER JOIN eventos_realizados ON eventos_realizados.espetaculo_id != espetaculos.id",
                                   :group => :id).collect {|u| [u.nome, u.id]}

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @er }
    end
  end

  # GET /cidades/1/edit
  def edit
    @er = EventosRealizados.find(params[:id])
    @espetaculos = Espetaculo.find(:all, :order => :nome, :group => :id).collect {|u| [u.nome, u.id]}
  end

  # POST /cidades
  # POST /cidades.xml
  def create
    @er = EventosRealizados.new(params[:eventos_realizados])

    respond_to do |format|
      if @er.save
        flash[:notice] = 'Evento realizado was successfully created.'
        format.html { redirect_to(:action => :admin_index) }
        format.xml  { render :xml => @er, :status => :created, :location => @er }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @er.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cidades/1
  # PUT /cidades/1.xml
  def update
    @er = EventosRealizados.find(params[:id])

    respond_to do |format|
      if @er.update_attributes(params[:eventos_realizados])
        flash[:notice] = 'Evento realizado was successfully updated.'
        format.html { redirect_to(:action => :admin_index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @er.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cidades/1
  # DELETE /cidades/1.xml
  def destroy
    @er = EventosRealizados.find(params[:id])
    @er.destroy

    respond_to do |format|
      format.html { redirect_to(cidades_url) }
      format.xml  { head :ok }
    end
  end
end
