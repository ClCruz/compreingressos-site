class EspeciaisController < ApplicationController
  before_filter :authorize, :except => [:show]
  newrelic_ignore :except => [:show]
  layout 'compreingressos'
  
  # GET /especiais
  # GET /especiais.xml
  def index
    @especiais = Especial.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @especiais }
    end
  end

  # GET /especiais/1
  # GET /especiais/1.xml
  def show
    @especial = Especial.find(params[:id])
    @title = @especial.titulo
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @especial }
    end
  end

  # GET /especiais/new
  # GET /especiais/new.xml
  def new
    @especial = Especial.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @especial }
    end
  end

  # GET /especiais/1/edit
  def edit
    @especial = Especial.find(params[:id])
  end

  # POST /especiais
  # POST /especiais.xml
  def create
    @especial = Especial.new(params[:especial])

    respond_to do |format|
      if @especial.save
        flash[:notice] = 'Especial was successfully created.'
        format.html { redirect_to(@especial) }
        format.xml  { render :xml => @especial, :status => :created, :location => @especial }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @especial.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /especiais/1
  # PUT /especiais/1.xml
  def update
    @especial = Especial.find(params[:id])

    respond_to do |format|
      if @especial.update_attributes(params[:especial])
        flash[:notice] = 'Especial was successfully updated.'
        format.html { redirect_to(@especial) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @especial.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /especiais/1
  # DELETE /especiais/1.xml
  def destroy
    @especial = Especial.find(params[:id])
    @especial.destroy

    respond_to do |format|
      format.html { redirect_to(especiais_url) }
      format.xml  { head :ok }
    end
  end
end
