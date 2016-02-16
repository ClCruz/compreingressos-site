class ClassificacaosController < ApplicationController
  before_filter :authorize
  newrelic_ignore_apdex
  layout 'compreingressos_antigo'
  
  # GET /classificacaos
  # GET /classificacaos.xml
  def index
    @classificacaos = Classificacao.find(:all, :order => :nome)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @classificacaos }
    end
  end

  # GET /classificacaos/1
  # GET /classificacaos/1.xml
  def show
    @classificacao = Classificacao.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @classificacao }
    end
  end

  # GET /classificacaos/new
  # GET /classificacaos/new.xml
  def new
    @classificacao = Classificacao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @classificacao }
    end
  end

  # GET /classificacaos/1/edit
  def edit
    @classificacao = Classificacao.find(params[:id])
  end

  # POST /classificacaos
  # POST /classificacaos.xml
  def create
    @classificacao = Classificacao.new(params[:classificacao])

    respond_to do |format|
      if @classificacao.save
        flash[:notice] = 'Classificacao was successfully created.'
        format.html { redirect_to(@classificacao) }
        format.xml  { render :xml => @classificacao, :status => :created, :location => @classificacao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @classificacao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /classificacaos/1
  # PUT /classificacaos/1.xml
  def update
    @classificacao = Classificacao.find(params[:id])

    respond_to do |format|
      if @classificacao.update_attributes(params[:classificacao])
        flash[:notice] = 'Classificacao was successfully updated.'
        format.html { redirect_to(@classificacao) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @classificacao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /classificacaos/1
  # DELETE /classificacaos/1.xml
  def destroy
    @classificacao = Classificacao.find(params[:id])
    @classificacao.destroy

    respond_to do |format|
      format.html { redirect_to(classificacaos_url) }
      format.xml  { head :ok }
    end
  end
end
