class VisoresController < ApplicationController
  before_filter :authorize, :except => [:index, :lista]
  newrelic_ignore :except => [:index, :lista]
  layout 'compreingressos_antigo'
  
  # GET /visores
  # GET /visores.xml
  def index
    @visores = Visor.all(:order => 'visores.order')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @visores }
    end
  end

  # GET /visores/1
  # GET /visores/1.xml
  def show
    @visor = Visor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @visor }
    end
  end

  # GET /visores/new
  # GET /visores/new.xml
  def new
    @visor = Visor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @visor }
    end
  end

  # GET /visores/1/edit
  def edit
    @visor = Visor.find(params[:id])
  end

  # POST /visores
  # POST /visores.xml
  def create
    @visor = Visor.new(params[:visor])

    respond_to do |format|
      if @visor.save
        format.html { redirect_to(visores_url, :notice => 'Visor was successfully created.') }
        format.xml  { render :xml => @visor, :status => :created, :location => @visor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @visor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /visores/1
  # PUT /visores/1.xml
  def update
    @visor = Visor.find(params[:id])

    respond_to do |format|
      if @visor.update_attributes(params[:visor])
        format.html { redirect_to(visores_url, :notice => 'Visor was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @visor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /visores/1
  # DELETE /visores/1.xml
  def destroy
    @visor = Visor.find(params[:id])
    @visor.destroy

    respond_to do |format|
      format.html { redirect_to(visores_url) }
      format.xml  { head :ok }
    end
  end

  def reorganiza
    begin
      params[:visor].each_with_index do |id, i|
        obj = Visor.find(:first, :conditions => {:id => id})
        obj.order = i
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
  
  # http://www.compreingressos.com/visores/lista.json?key=8435D5115e46a70i6648715850882eus
  def lista
    @visores = Visor.find(:all, :conditions => ["imagem_mobile_file_name IS NOT NULL"],:order => 'visores.order')
    render :file => 'visores/lista.json.erb', :content_type => 'application/json' if params[:key] == Espetaculo::KEY_TOKECOMPRE_APP
  end
end