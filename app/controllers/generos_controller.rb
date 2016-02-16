class GenerosController < ApplicationController
  before_filter :authorize
  newrelic_ignore_apdex
  layout 'compreingressos_antigo'
  
  # GET /generos
  # GET /generos.xml
  def index
    @generos = Genero.find(:all, :order => :nome)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @generos }
    end
  end

  # GET /generos/1
  # GET /generos/1.xml
  def show
    @genero = Genero.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @genero }
    end
  end

  # GET /generos/new
  # GET /generos/new.xml
  def new
    @genero = Genero.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @genero }
    end
  end

  # GET /generos/1/edit
  def edit
    @genero = Genero.find(params[:id])
  end

  # POST /generos
  # POST /generos.xml
  def create
    @genero = Genero.new(params[:genero])

    respond_to do |format|
      if @genero.save
        flash[:notice] = 'Genero was successfully created.'
        format.html { redirect_to(@genero) }
        format.xml  { render :xml => @genero, :status => :created, :location => @genero }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @genero.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /generos/1
  # PUT /generos/1.xml
  def update
    @genero = Genero.find(params[:id])

    respond_to do |format|
      if @genero.update_attributes(params[:genero])
        flash[:notice] = 'Genero was successfully updated.'
        format.html { redirect_to(@genero) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @genero.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /generos/1
  # DELETE /generos/1.xml
  def destroy
    @genero = Genero.find(params[:id])
    @genero.destroy

    respond_to do |format|
      format.html { redirect_to(generos_url) }
      format.xml  { head :ok }
    end
  end
end
