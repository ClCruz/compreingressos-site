class OutrasLocalidadesController < ApplicationController
  before_filter :authorize
  newrelic_ignore_apdex
  
  # GET /outras_localidades
  # GET /outras_localidades.xml
  def index
    cidades = Cidade.find(:all, :order => :nome)
    
    @outras_localidades = []
    for cidade in cidades
      @outras_localidades << cidade.outras_localidade if cidade.outras_localidade
    end
    #@outras_localidades = OutrasLocalidade.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @outras_localidades }
    end
  end

  # GET /outras_localidades/1
  # GET /outras_localidades/1.xml
  def show
    @outras_localidade = OutrasLocalidade.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @outras_localidade }
    end
  end

  # GET /outras_localidades/new
  # GET /outras_localidades/new.xml
  def new
    @outras_localidade = OutrasLocalidade.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @outras_localidade }
    end
  end

  # GET /outras_localidades/1/edit
  def edit
    @outras_localidade = OutrasLocalidade.find(params[:id])
  end

  # POST /outras_localidades
  # POST /outras_localidades.xml
  def create
    @outras_localidade = OutrasLocalidade.new(params[:outras_localidade])

    respond_to do |format|
      if @outras_localidade.save
        flash[:notice] = 'OutrasLocalidade was successfully created.'
        format.html { redirect_to(edit_outras_localidade_path(@outras_localidade)) }
        format.xml  { render :xml => @outras_localidade, :status => :created, :location => @outras_localidade }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @outras_localidade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /outras_localidades/1
  # PUT /outras_localidades/1.xml
  def update
    @outras_localidade = OutrasLocalidade.find(params[:id])
    @outras_localidade.espetaculos = []
    @outras_localidade.save
    params[:outras_localidade][:espetaculo_ids] ||= []

    respond_to do |format|
      if @outras_localidade.update_attributes(params[:outras_localidade])
        flash[:notice] = 'OutrasLocalidade was successfully updated.'
        format.html { redirect_to(edit_outras_localidade_path(@outras_localidade)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @outras_localidade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /outras_localidades/1
  # DELETE /outras_localidades/1.xml
  def destroy
    @outras_localidade = OutrasLocalidade.find(params[:id])
    @outras_localidade.destroy

    respond_to do |format|
      format.html { redirect_to(outras_localidades_url) }
      format.xml  { head :ok }
    end
  end
  
  def reorganiza
    begin
      params[:espetaculo_outras_localidade].each_with_index do |id, i|
        obj = EspetaculosOutrasLocalidade.find(:first, :conditions => {:outras_localidade_id => params[:outras_localidade], :espetaculo_id => id})
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
