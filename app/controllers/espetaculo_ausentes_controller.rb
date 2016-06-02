class EspetaculoAusentesController < ApplicationController
  before_filter :authorize
  layout 'compreingressos_antigo'

  # GET /espetaculo_ausentes
  # GET /espetaculo_ausentes.xml
  def index
    @espetaculo_ausentes = EspetaculoAusente.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @espetaculo_ausentes }
    end
  end

  # GET /espetaculo_ausentes/1
  # GET /espetaculo_ausentes/1.xml
  def show
    @espetaculo_ausente = EspetaculoAusente.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @espetaculo_ausente }
    end
  end

  # GET /espetaculo_ausentes/new
  # GET /espetaculo_ausentes/new.xml
  def new
    @espetaculo_ausente = EspetaculoAusente.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @espetaculo_ausente }
    end
  end

  # GET /espetaculo_ausentes/1/edit
  def edit
    @espetaculo_ausente = EspetaculoAusente.find(params[:id])
  end

  # POST /espetaculo_ausentes
  # POST /espetaculo_ausentes.xml
  def create
    @espetaculo_ausente = EspetaculoAusente.new(params[:espetaculo_ausente])

    respond_to do |format|
      if @espetaculo_ausente.save
        format.html { redirect_to(@espetaculo_ausente, :notice => 'EspetaculoAusente was successfully created.') }
        format.xml  { render :xml => @espetaculo_ausente, :status => :created, :location => @espetaculo_ausente }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @espetaculo_ausente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /espetaculo_ausentes/1
  # PUT /espetaculo_ausentes/1.xml
  def update
    @espetaculo_ausente = EspetaculoAusente.find(params[:id])

    respond_to do |format|
      if @espetaculo_ausente.update_attributes(params[:espetaculo_ausente])
        format.html { redirect_to(@espetaculo_ausente, :notice => 'EspetaculoAusente was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @espetaculo_ausente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /espetaculo_ausentes/1
  # DELETE /espetaculo_ausentes/1.xml
  def destroy
    @espetaculo_ausente = EspetaculoAusente.find(params[:id])
    @espetaculo_ausente.destroy

    respond_to do |format|
      format.html { redirect_to(espetaculo_ausentes_url) }
      format.xml  { head :ok }
    end
  end

  # POST /espetaculo_ausentes
  # POST /espetaculo_ausentes.xml
  def save
    @espetaculo_ausente = EspetaculoAusente.new(params[:espetaculo_ausente])

    respond_to do |format|
      if @espetaculo_ausente.save
        format.html { redirect_to(@espetaculo_ausente, :notice => 'EspetaculoAusente was successfully created.') }
        format.xml  { render :xml => @espetaculo_ausente, :status => :created, :location => @espetaculo_ausente }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @espetaculo_ausente.errors, :status => :unprocessable_entity }
      end
    end
  end

  def exportar
    @espetaculo_ausentes = EspetaculoAusente.all   

    respond_to do |format|
      format.csv do
        response.headers["Content-Type"] = "text/csv; header=present"
        response.headers["Content-Disposition"] = "attachment; filename=#{DateTime.now.strftime("%Y-%m-%d-%H-%M-espetaculos")}.csv"
      end
    end
  end

end
