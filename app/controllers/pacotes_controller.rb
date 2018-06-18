class PacotesController < ApplicationController
  before_filter :authorize
  newrelic_ignore_apdex
  layout 'compreingressos_antigo'
  
  # GET /pacotes
  # GET /pacotes.xml
  def index
    @pacotes = Pacote.find(:all, :conditions => {:pagina_de_pacote_id => params[:id]}, :order => :ordem)
    #@pacotes = Pacote.find(:all,
    #                       :joins => ["INNER JOIN pacote_filtros ON pacote_filtros.url = #{params[:filtro]}",
    #                                  "INNER JOIN pacote_filtros_pacotes ON pacotes.id = pacote_filtros_pacotes.pacote_id and pacote_filtros_pacotes.pacote_filtro_id = pacote_filtros.id "],
    #                       :conditions => {:pagina_de_pacote_id => params[:id]},
    #                       :order => :ordem)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pacotes }
    end
  end

  # GET /pacotes/1
  # GET /pacotes/1.xml
  def show
    @pacote = Pacote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pacote }
    end
  end

  # GET /pacotes/new
  # GET /pacotes/new.xml
  def new
    @pacote = Pacote.new
    @espetaculos = Espetaculo.find(:all, 
                                   :select => "espetaculos.id, espetaculos.nome, teatros.nome", 
                                   :include => :teatro, 
                                   :conditions => "teatros.id is not null",
                                   :order => 'espetaculos.nome').map{ |e| ["#{e.nome.gsub('"',"'")} (#{e.teatro.nome.gsub('"',"'")})", e.id] }
    if params[:id]
      @pacote.pagina_de_pacote_id = params[:id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pacote }
    end
  end

  # GET /pacotes/1/edit
  def edit
    @pacote = Pacote.find(params[:id])
    @espetaculos = Espetaculo.find(:all, 
                                   :select => "espetaculos.id, espetaculos.nome, teatros.nome", 
                                   :include => :teatro, 
                                   :conditions => "teatros.id is not null",
                                   :order => 'espetaculos.nome').map{ |e| ["#{e.nome.gsub('"',"'")} (#{e.teatro.nome.gsub('"',"'")})", e.id] }
  end

  # POST /pacotes
  # POST /pacotes.xml
  def create
    @pacote = Pacote.new(params[:pacote])
    @espetaculos = Espetaculo.find(:all, 
                                   :select => "espetaculos.id, espetaculos.nome, teatros.nome", 
                                   :include => :teatro, 
                                   :conditions => "teatros.id is not null",
                                   :order => 'espetaculos.nome').map{ |e| ["#{e.nome.gsub('"',"'")} (#{e.teatro.nome.gsub('"',"'")})", e.id] }
    
    # ROTINA PARA PEGAR O ID DA PRIMEIRA APRESENTAÇÃO, POIS PACOTES SÓ TEM 1 ID DE APRESENTAÇÃO E
    # ELE VAI PARA O CAMPO QUE GERA O LINK QUE MANDA O USUARIO PARA A PARTE DE COMPRA
#    if @pacote.cc_id and (Rails.env=="production" or Rails.env=="staging")
#      require 'open-uri'
#      require 'json'    
#      
#      doc = open("#{ENVIRONMENT_VARS['host_json']}/comprar/timeTable.php?evento=#{@pacote.cc_id}")
#      doc.rewind
#      data = doc.readlines.join("\n").strip
#      apresentacaoId = @pacote.cc_evento_id
#      if !data.blank?
#        apresentacoes = JSON.parse(data)
#        apresentacoes['horarios'].each do |a|
#          apresentacaoId = a['idApresentacao']
#        end
#      end
#      #@pacote.cc_evento_id = apresentacaoId
#    end
    
    respond_to do |format|
      if @pacote.save
        format.html { redirect_to("/pacotes?id=#{@pacote.pagina_de_pacote_id}") }
        format.xml  { render :xml => @pacote, :status => :created, :location => @pacote }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pacote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pacotes/1
  # PUT /pacotes/1.xml
  def update
    params[:pacote][:pacote_filtro_ids] ||= []
    @pacote = Pacote.find(params[:id])
    @espetaculos = Espetaculo.find(:all, :select => "espetaculos.id, espetaculos.nome, teatros.nome", :include => :teatro, :order => 'espetaculos.nome').map{|e| ["#{e.nome.gsub('"',"'")} (#{e.teatro.nome})",e.id]}
    
    # ROTINA PARA PEGAR O ID DA PRIMEIRA APRESENTAÇÃO, POIS PACOTES SÓ TEM 1 ID DE APRESENTAÇÃO E
    # ELE VAI PARA O CAMPO QUE GERA O LINK QUE MANDA O USUARIO PARA A PARTE DE COMPRA
#    if @pacote.cc_id and (Rails.env=="production" or Rails.env=="staging")
#      require 'open-uri'
#      require 'json'
#      #logger.warn "entrou\n\n\n"
#      
#      doc = open("#{ENVIRONMENT_VARS['host_json']}/comprar/timeTable.php?evento=#{@pacote.cc_id}")
#      #logger. warn "#{ENVIRONMENT_VARS['host_json']}/comprar/timeTable.php?evento=#{@pacote.cc_id}"
#      doc.error
#      data = doc.readlines.join("\n").strip
#      #logger.error data
#      apresentacaoId = @pacote.cc_evento_id
#      if !data.blank?
#        apresentacoes = JSON.parse(data)
#        apresentacoes['horarios'].each do |a|
#          apresentacaoId = a['idApresentacao']
#          #logger.error "#{a['idApresentacao']}\n\n\n"
#        end
#      end
#      #@pacote.cc_evento_id = apresentacaoId
#    end

    respond_to do |format|
      if @pacote.update_attributes(params[:pacote])
        pacote = @pacote.pacote_filtros.find(:last).url
        format.html { redirect_to("/#{@pacote.pagina_de_pacote.url}/assinaturas/#{pacote}") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pacote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pacotes/1
  # DELETE /pacotes/1.xml
  def destroy
    @pacote = Pacote.find(params[:id])
    @pacote.destroy

    respond_to do |format|
      format.html { redirect_to(pacotes_url+"?id=#{@pacote.pagina_de_pacote_id}") }
      format.xml  { head :ok }
    end
  end

  def reorganiza
    begin
      params[:pacote].each_with_index do |id, i|
        obj = Pacote.find(:first, :conditions => {:id => id, :pagina_de_pacote_id => params[:id]})
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
