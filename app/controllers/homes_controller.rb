class HomesController < ApplicationController
  before_filter :authorize
  newrelic_ignore_apdex
  layout 'compreingressos_antigo'
  
  # GET /homes
  # GET /homes.xml
  def index
    cidades = Cidade.find(:all, :order => :nome)
    
    @homes = []
    for cidade in cidades
      @homes << cidade.home if cidade.home
    end
    #@homes = Home.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @homes }
    end
  end

  # GET /homes/1
  # GET /homes/1.xml
  def show
    @home = Home.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @home }
    end
  end

  # GET /homes/new
  # GET /homes/new.xml
  def new
    @home = Home.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @home }
    end
  end

  # GET /homes/1/edit
  def edit
    @home = Home.find(params[:id])
  end

  # POST /homes
  # POST /homes.xml
  def create
    @home = Home.new(params[:home])

    respond_to do |format|
      if @home.save
        flash[:notice] = 'Home was successfully created.'
        format.html { redirect_to(edit_home_path(@home)) }
        format.xml  { render :xml => @home, :status => :created, :location => @home }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @home.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /homes/1
  # PUT /homes/1.xml
  def update
    @home = Home.find(params[:id])
    @home.espetaculos = []
    @home.save
    params[:home][:espetaculo_ids] ||= []
    
    respond_to do |format|
      if @home.update_attributes(params[:home])
        flash[:notice] = 'Home was successfully updated.'
        format.html { redirect_to(edit_home_path(@home)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @home.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.xml
  def destroy
    @home = Home.find(params[:id])
    @home.destroy

    respond_to do |format|
      format.html { redirect_to(homes_url) }
      format.xml  { head :ok }
    end
  end
  
  def reorganiza
    begin
      params[:espetaculo_home].each_with_index do |id, i|
        obj = EspetaculosHome.find(:first, :conditions => {:home_id => params[:home], :espetaculo_id => id})
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