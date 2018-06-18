class BannerFixosController < ApplicationController
  before_filter :authorize
  newrelic_ignore_apdex
  layout 'compreingressos_antigo'
  
  # GET /banner_fixos
  # GET /banner_fixos.xml
  def index
    @banner_fixos = BannerFixo.all(:order => 'banner_fixos.ordem DESC')

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /banner_fixos/1
  # GET /banner_fixos/1.xml
  def show
    @banner_fixo = BannerFixo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @banner_fixo }
    end
  end

  # GET /banner_fixos/new
  # GET /banner_fixos/new.xml
  def new
    @banner_fixo = BannerFixo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @banner_fixo }
    end
  end

  # GET /banner_fixos/1/edit
  def edit
    @banner_fixo = BannerFixo.find(params[:id])
  end

  # POST /banner_fixos
  # POST /banner_fixos.xml
  def create
    @banner_fixo = BannerFixo.new(params[:banner_fixo])

    respond_to do |format|
      if @banner_fixo.save
        format.html { redirect_to(banner_fixos_url, :notice => 'BannerFixo was successfully created.') }
        format.xml  { render :xml => @banner_fixo, :status => :created, :location => @banner_fixo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @banner_fixo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /banner_fixos/1
  # PUT /banner_fixos/1.xml
  def update
    @banner_fixo = BannerFixo.find(params[:id])

    respond_to do |format|
      if @banner_fixo.update_attributes(params[:banner_fixo])
        format.html { redirect_to(banner_fixos_url, :notice => 'BannerFixo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @banner_fixo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /banner_fixos/1
  # DELETE /banner_fixos/1.xml
  def destroy
    @banner_fixo = BannerFixo.find(params[:id])
    @banner_fixo.destroy

    respond_to do |format|
      format.html { redirect_to(banner_fixos_url) }
      format.xml  { head :ok }
    end
  end

  def reorganiza
    begin
      params[:banner_fixo].each_with_index do |id, i|
        obj = BannerFixo.find(:first, :conditions => {:id => id})
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
