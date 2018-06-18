class NewslettersController < ApplicationController
  layout 'compreingressos_antigo'
  before_filter :authorize, :except => [:show]

  # GET /newsletters
  # GET /newsletters.xml
  def index        
    @newsletters = Newsletter.find(:all, :order => "newsletters.data DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @newsletters }
    end
  end

  # GET /newsletters/1
  # GET /newsletters/1.xml
  def show
    @newsletter = Newsletter.find(params[:id])
    if @newsletter != nil
      @data_inicial = @newsletter.data
      @data_final = @data_inicial + 14
    end

    @espetaculos = Espetaculo.find(:all,
                                   :include => :horarios,
                                   :conditions => ["espetaculos.teatro_id in (490, 498)"],
                                   :order => "espetaculos.destaque_newsletter DESC, espetaculos.nome")
    @destaque = @espetaculos[0]
    @destaque1 = @espetaculos[1]
    @destaque2 = @espetaculos[2]

    respond_to do |format|
      format.html { render :layout => 'newsletters' } # show.html.erb
      format.xml  { render :xml => @newsletter }
    end
  end

  # GET /newsletters/new
  # GET /newsletters/new.xml
  def new
    @newsletter = Newsletter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @newsletter }
    end
  end

  # GET /newsletters/1/edit
  def edit
    @newsletter = Newsletter.find(params[:id])
  end

  # POST /newsletters
  # POST /newsletters.xml
  def create
    @newsletter = Newsletter.new(params[:newsletter])

    respond_to do |format|
      if @newsletter.save
        format.html { redirect_to(@newsletter, :notice => 'Newsletter was successfully created.') }
        format.xml  { render :xml => @newsletter, :status => :created, :location => @newsletter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @newsletter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /newsletters/1
  # PUT /newsletters/1.xml
  def update
    @newsletter = Newsletter.find(params[:id])

    respond_to do |format|
      if @newsletter.update_attributes(params[:newsletter])
        format.html { redirect_to(@newsletter, :notice => 'Newsletter was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @newsletter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /newsletters/1
  # DELETE /newsletters/1.xml
  def destroy
    @newsletter = Newsletter.find(params[:id])
    @newsletter.destroy

    respond_to do |format|
      format.html { redirect_to(newsletters_url) }
      format.xml  { head :ok }
    end
  end

    # Exclui a imagem desejada no formulario de administracao
  def excluir_img
    @newsletter = Newsletter.find(params[:id])
    @newsletter.img_destaque.clear    
    @newsletter.save

    redirect_to(edit_newsletter_path(@newsletter))
  end
end
