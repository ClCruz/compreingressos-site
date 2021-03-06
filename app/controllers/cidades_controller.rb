class CidadesController < ApplicationController
  before_filter :authorize
  newrelic_ignore_apdex
  layout 'compreingressos_antigo'
  
  # GET /cidades
  # GET /cidades.xml
  def index
    @cidades = Cidade.find(:all, :order => :nome)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cidades }
    end
  end

  # GET /cidades/1
  # GET /cidades/1.xml
  def show
    @cidade = Cidade.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cidade }
    end
  end

  # GET /cidades/new
  # GET /cidades/new.xml
  def new
    @cidade = Cidade.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cidade }
    end
  end

  # GET /cidades/1/edit
  def edit
    @cidade = Cidade.find(params[:id])
  end

  # POST /cidades
  # POST /cidades.xml
  def create
    @cidade = Cidade.new(params[:cidade])

    respond_to do |format|
      if @cidade.save
        flash[:notice] = 'Cidade was successfully created.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cidade, :status => :created, :location => @cidade }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cidade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cidades/1
  # PUT /cidades/1.xml
  def update
    @cidade = Cidade.find(params[:id])

    respond_to do |format|
      if @cidade.update_attributes(params[:cidade])
        flash[:notice] = 'Cidade was successfully updated.'
        format.html { render :action => "edit" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cidade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cidades/1
  # DELETE /cidades/1.xml
  def destroy
    @cidade = Cidade.find(params[:id])
    @cidade.destroy

    respond_to do |format|
      format.html { redirect_to(cidades_url) }
      format.xml  { head :ok }
    end
  end
  
  def excluir_img
    @cidade = Cidade.find(params[:id])
    if params[:tipo]=='fundo'
      @cidade.imagem_de_fundo.clear
    end
    @cidade.save
    redirect_to(edit_cidade_path(@cidade))
  end
end
