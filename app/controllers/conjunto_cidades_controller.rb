class ConjuntoCidadesController < ApplicationController
  layout 'compreingressos_antigo'

  
  # GET /conjunto_cidades
  # GET /conjunto_cidades.xml
  def index
    @conjunto_cidades = ConjuntoCidade.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @conjunto_cidades }
    end
  end

  # GET /conjunto_cidades/1
  # GET /conjunto_cidades/1.xml
  def show
    @conjunto_cidade = ConjuntoCidade.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @conjunto_cidade }
    end
  end

  # GET /conjunto_cidades/new
  # GET /conjunto_cidades/new.xml
  def new
    @conjunto_cidade = ConjuntoCidade.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @conjunto_cidade }
    end
  end

  # GET /conjunto_cidades/1/edit
  def edit
    @conjunto_cidade = ConjuntoCidade.find(params[:id])
  end

  # POST /conjunto_cidades
  # POST /conjunto_cidades.xml
  def create
    @conjunto_cidade = ConjuntoCidade.new(params[:conjunto_cidade])

    respond_to do |format|
      if @conjunto_cidade.save
        format.html { redirect_to(conjunto_cidades_path, :notice => 'ConjuntoCidade was successfully created.') }
        format.xml  { render :xml => @conjunto_cidade, :status => :created, :location => @conjunto_cidade }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @conjunto_cidade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /conjunto_cidades/1
  # PUT /conjunto_cidades/1.xml
  def update
    @conjunto_cidade = ConjuntoCidade.find(params[:id])
    params[:conjunto_cidade][:cidade_ids] ||= []

    respond_to do |format|
      if @conjunto_cidade.update_attributes(params[:conjunto_cidade])
        format.html { redirect_to(conjunto_cidades_path, :notice => 'ConjuntoCidade was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @conjunto_cidade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /conjunto_cidades/1
  # DELETE /conjunto_cidades/1.xml
  def destroy
    @conjunto_cidade = ConjuntoCidade.find(params[:id])
    @conjunto_cidade.destroy

    respond_to do |format|
      format.html { redirect_to(conjunto_cidades_url) }
      format.xml  { head :ok }
    end
  end

  def excluir_img
    @conjunto_cidade = ConjuntoCidade.find(params[:id])
    if params[:tipo]=='fundo'
      @conjunto_cidade.imagem_de_fundo.clear
    end
    @conjunto_cidade.save
    redirect_to(edit_conjunto_cidade_path(@conjunto_cidade))
  end
end
