class PontosdevendaController < ApplicationController
  before_filter :authorize
  newrelic_ignore_apdex
  layout 'compreingressos'
  
  # GET /pontosdevenda
  # GET /pontosdevenda.xml
  def index
    @cidades = []
    cidades = Cidade.all
    for cidade in cidades
      if cidade.pontosdevenda.size > 0
        @cidades << cidade
      end
    end
    
    if params[:cidade]
      @cid = Cidade.find_by_nome(params[:cidade])
      @pontosdevenda = @cid.pontosdevenda
    else
      @cid = Cidade.first
      @pontosdevenda = @cid.pontosdevenda
    end
    

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pontosdevenda }
    end
  end

  # GET /pontosdevenda/1
  # GET /pontosdevenda/1.xml
  def show
    @pontodevenda = Pontodevenda.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pontodevenda }
    end
  end

  # GET /pontosdevenda/new
  # GET /pontosdevenda/new.xml
  def new
    @pontodevenda = Pontodevenda.new

    respond_to do |format|
      format.html { render :layout => 'compreingressos_antigo' }
      format.xml  { render :xml => @pontodevenda }
    end
  end

  # GET /pontosdevenda/1/edit
  def edit
    @pontodevenda = Pontodevenda.find(params[:id])
    render :layout => 'compreingressos_antigo'
  end

  # POST /pontosdevenda
  # POST /pontosdevenda.xml
  def create
    @pontodevenda = Pontodevenda.new(params[:pontodevenda])

    respond_to do |format|
      if @pontodevenda.save
        flash[:notice] = 'Pontodevenda was successfully created.'
        format.html { redirect_to(@pontodevenda) }
        format.xml  { render :xml => @pontodevenda, :status => :created, :location => @pontodevenda }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pontodevenda.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pontosdevenda/1
  # PUT /pontosdevenda/1.xml
  def update
    @pontodevenda = Pontodevenda.find(params[:id])

    respond_to do |format|
      if @pontodevenda.update_attributes(params[:pontodevenda])
        flash[:notice] = 'Pontodevenda was successfully updated.'
        format.html { redirect_to(@pontodevenda) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pontodevenda.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pontosdevenda/1
  # DELETE /pontosdevenda/1.xml
  def destroy
    @pontodevenda = Pontodevenda.find(params[:id])
    @pontodevenda.destroy

    respond_to do |format|
      format.html { redirect_to(pontosdevenda_url) }
      format.xml  { head :ok }
    end
  end
end
