class ServicosController < ApplicationController
  before_filter :authorize, :except => [:index, :show]
  newrelic_ignore :except => [:index, :show]

  # GET /servicos
  # GET /servicos.xml
  def index
    @servicos = Servico.all
    @title = "Serviços"
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @servicos }
    end
  end

  # GET /servicos/1
  # GET /servicos/1.xml
  def show
    @servico = Servico.find(params[:id])
    @servicos = Servico.all
    @title = @servico.titulo
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @servico }
    end
  end

  # GET /servicos/new
  # GET /servicos/new.xml
  def new
    @servico = Servico.new

    respond_to do |format|
      format.html { render :layout => 'compreingressos_antigo' }
      format.xml  { render :xml => @servico }
    end
  end

  # GET /servicos/1/edit
  def edit
    @servico = Servico.find(params[:id])
    render :layout => 'compreingressos_antigo'
  end

  # POST /servicos
  # POST /servicos.xml
  def create
    @servico = Servico.new(params[:servico])

    respond_to do |format|
      if @servico.save
        flash[:notice] = 'Servico was successfully created.'
        format.html { redirect_to(@servico) }
        format.xml  { render :xml => @servico, :status => :created, :location => @servico }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @servico.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /servicos/1
  # PUT /servicos/1.xml
  def update
    @servico = Servico.find(params[:id])

    respond_to do |format|
      if @servico.update_attributes(params[:servico])
        flash[:notice] = 'Servico was successfully updated.'
        format.html { redirect_to(@servico) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @servico.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /servicos/1
  # DELETE /servicos/1.xml
  def destroy
    @servico = Servico.find(params[:id])
    @servico.destroy

    respond_to do |format|
      format.html { redirect_to(servicos_url) }
      format.xml  { head :ok }
    end
  end
end
