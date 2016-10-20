class PontosdevendaController < ApplicationController
  before_filter :authorize, :except => [:index]
  newrelic_ignore_apdex
  layout 'compreingressos'
  
  # GET /pontosdevenda
  # GET /pontosdevenda.xml
  def index
    if params[:estado]
      busca = params[:busca] == "local, endereço, funcionamento..." ? "" : params["busca"]
      estado = params[:estado]      
      if params[:estado] != "0"
        if busca == ""
          @pontosdevenda = Pontodevenda.find(:all, :conditions => ["pontosdevenda.estado_id = :estado", {:estado => "#{estado}"}], :order => "pontosdevenda.local")
        else
          @pontosdevenda = Pontodevenda.find(:all, :conditions => ["(pontosdevenda.local LIKE :busca OR pontosdevenda.endereco LIKE :busca OR pontosdevenda.funcionamento LIKE :busca) AND (pontosdevenda.estado_id = :estado)", {:busca => "%#{busca}%", :estado => "#{estado}"}], :order => "pontosdevenda.local")
        end
      else
        if busca == ""
          @pontosdevenda = Pontodevenda.find(:all, :conditions => ["(pontosdevenda.local LIKE :busca OR pontosdevenda.endereco LIKE :busca OR pontosdevenda.funcionamento LIKE :busca)", {:busca => "%#{busca}%"}], :order => "pontosdevenda.local")
        else
          @pontosdevenda = Pontodevenda.find(:all, :order => "pontosdevenda.local")
        end
      end
    else
      @pontosdevenda = Pontodevenda.find(:all, :order => "pontosdevenda.local")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pontosdevenda }
    end
  end

  # GET /pontosdevenda
  # GET /pontosdevenda.xml
  def admin_index 
    @pontosdevenda = Pontodevenda.all
    respond_to do |format|
      format.html { render :layout => 'compreingressos_antigo' }
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
        format.html { redirect_to('/pontosdevendas') }
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
        format.html { redirect_to('/pontosdevendas') }
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
      format.html { redirect_to('/pontosdevendas') }
      format.xml  { head :ok }
    end
  end
end
