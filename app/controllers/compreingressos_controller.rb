require 'digest'

class CompreingressosController < ApplicationController
  skip_before_filter :authorize
  newrelic_ignore :only => [:desativaentradasprogramadas]
  
  def index
    unless session[:cidade_id]
      session[:cidade_id] = 1
    end
    
    if Time.now.hour == 0
      if Time.now.min < 15
        desativaentradasprogramadas
      end
    end
    if Time.now.hour == 9
      if Time.now.min < 15
        desativaentradasprogramadas
      end
    end
    #sac@compreingressos.com senha: 301226clc
    if params[:pagseguro]=='1'
      i = Intensivamedcontador.find(1)
      i.total = i.total+1
      i.save
      redirect_to('/')
    end
    
    cidade = Cidade.find(session[:cidade_id])
        
    @visores_esquerda = Visor.all(:conditions => ["data_de_expiracao >= ? AND posicao = 'esquerda'", DateTime.now.in_time_zone('Brasilia')], :order => 'visores.order')
    @visores_direita = Visor.all(:conditions => ["data_de_expiracao >= ? AND posicao = 'direita'", DateTime.now.in_time_zone('Brasilia')], :order => 'visores.order')
    @banner_fixos = BannerFixo.all(:order => "ordem DESC")
    @home_modulos = HomeModulo.find(:all, :conditions => ["entrada <= ? AND saida > ?", DateTime.now.in_time_zone('Brasilia'), DateTime.now.in_time_zone('Brasilia')], :order => :ordem)
    #@hm_last = HomeModulo.first(:select => :updated_at, :conditions => ["entrada <= ? AND saida > ?", DateTime.now.in_time_zone('Brasilia'), DateTime.now.in_time_zone('Brasilia')], :order => 'updated_at DESC').updated_at.to_i

    # criteo scripts
    @criteo_script_tag = "dataLayer.push({
                          'PageType': 'Homepage', 
                          'HashedEmail': ''
                        });"

    respond_to do |format|
      format.html { render :template => "compreingressos/index.html.erb" }
    end 
  end

  def app
    @title = "Aplicativo para iOS e Android já disponível"
    @keywords = "aplicativo compreingressos, app compreingressos, android, iOS, ingressos, promoções, compra ingressos, venda ingressos, teatro, teatro ingressos, teatro sao paulo, ingressos shows, shows, ingressos espetaculos, espetaculos, promocoes, ingressos gratis"
    @description = "Aplicativo Compreingressos. Conforto, agilidade e promoções com o mais moderno APP de compra de ingressos já desenvolvido. Seja vip, baixe agora e divirta-se!"
    @paginaapp = 1
  end
  
  def newsletter
    require 'rest-client'
    require 'json'
    #method=get_token&output=json&username=compreingressos_allinapi&password=NE7@NUPu
    response = RestClient.get(ENVIRONMENT_VARS["allin_host"], {:params => {'method' => 'get_token', 'output' => 'json', 'username' => ENVIRONMENT_VARS["allin_user"], 'password' => ENVIRONMENT_VARS["allin_pass"]}})
    if response.code == 200 
      json = JSON.parse(response.body)
      begin
        #{'nm_lista'=>'teste_site', 'campos'=>'nm_email;nome', 'valor'=>'edicarlosbarbosa@gmail.com;edicarlos'}
        dados = "[dados_email]{'nm_lista':'teste_site', 'campos':'nm_email;nome', 'valor':'edicarlosbarbosa@gmail.com;edicarlos'}"
        response = RestClient.post("#{ENVIRONMENT_VARS["allin_host"]}/?method=inserir_email_base&output=json&token=#{json["token"]}", {:params => {'[dados_email]' => "{'nm_lista':'teste_site'}"}})
        #, {:content_type => :json, :accept => :json}
        if response.code == 200          
          logger.warn(response)
          resp = 1
        end      
      rescue => e
        logger.error(e.response)
        resp = e.code
      end
    end
    #begin
    #  gb = Gibbon::API.new()
    #  gb.lists.subscribe({:id => "e17c7d7d48", :email => {:email => params[:email]}, :merge_vars => {:NOME => params[:nome], :UF => params[:uf], :ORIGEM => 1}, :double_optin => false})
    #  resp = 1
    #rescue Gibbon::MailChimpError => e
    #  resp = e.code
    #end
    
    respond_to do |format|
      format.html { render :text => resp }
    end    
  end
  
  private
  def desativaentradasprogramadas
    # Desativa espetaculos
    espetaculos = Espetaculo.find_by_sql("SELECT e.id FROM espetaculos e
                                                WHERE e.data_maxima IS NOT NULL
                                                  AND e.data_maxima < CURRENT_DATE()
                                                  AND (e.ativo = 1 OR e.privado = 1)")
    for esp in espetaculos
      espetaculo = Espetaculo.find(esp.id)
      espetaculo.update_attributes({:ativo => false, :privado => false})
    end
    
    # Exclui visores desativos
    visores = Visor.all(:conditions => ["data_de_expiracao < ?", DateTime.now.in_time_zone('Brasilia')])
    for v in visores
      v.destroy
    end
    
    #render :text => "#### SUCESSO ####"
  end

end