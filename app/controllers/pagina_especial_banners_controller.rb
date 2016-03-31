class PaginaEspecialBannersController < ApplicationController
  # GET /pagina_especial_banners
  # GET /pagina_especial_banners.xml
  def index
    @pagina_especial_banners = PaginaEspecialBanner.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pagina_especial_banners }
    end
  end

  # GET /pagina_especial_banners/1
  # GET /pagina_especial_banners/1.xml
  def show
    @pagina_especial_banner = PaginaEspecialBanner.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pagina_especial_banner }
    end
  end

  # GET /pagina_especial_banners/new
  # GET /pagina_especial_banners/new.xml
  def new
    @pagina_especial_banner = PaginaEspecialBanner.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pagina_especial_banner }
    end
  end

  # GET /pagina_especial_banners/1/edit
  def edit
    @pagina_especial_banner = PaginaEspecialBanner.find(params[:id])
  end

  # POST /pagina_especial_banners
  # POST /pagina_especial_banners.xml
  def create
    @pagina_especial_banner = PaginaEspecialBanner.new(params[:pagina_especial_banner])

    respond_to do |format|
      if @pagina_especial_banner.save
        format.html { redirect_to(@pagina_especial_banner, :notice => 'PaginaEspecialBanner was successfully created.') }
        format.xml  { render :xml => @pagina_especial_banner, :status => :created, :location => @pagina_especial_banner }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pagina_especial_banner.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pagina_especial_banners/1
  # PUT /pagina_especial_banners/1.xml
  def update
    @pagina_especial_banner = PaginaEspecialBanner.find(params[:id])

    respond_to do |format|
      if @pagina_especial_banner.update_attributes(params[:pagina_especial_banner])
        format.html { redirect_to(@pagina_especial_banner, :notice => 'PaginaEspecialBanner was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pagina_especial_banner.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pagina_especial_banners/1
  # DELETE /pagina_especial_banners/1.xml
  def destroy
    @pagina_especial_banner = PaginaEspecialBanner.find(params[:id])
    @pagina_especial_banner.destroy

    respond_to do |format|
      format.html { redirect_to(pagina_especial_banners_url) }
      format.xml  { head :ok }
    end
  end

  def reorganiza
    begin
      params[:pagina_especial_banner].each_with_index do |id, i|
        obj = PaginaEspecialBanner.find(:first, :conditions => {:id => id, :pagina_especial_id => params[:pagina_especial_id]})
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
