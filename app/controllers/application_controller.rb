# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  layout 'compreingressos'
  before_filter :authorize
  before_filter :setSEO, :mailchimpecommerce360
  before_filter :check_desktop_version, :check_baixeapp#, :check_location
  before_filter :set_csp, :set_publicidade

  filter_parameter_logging :password, :password_confirmation, :senha, :senha_confirmation # Remove do log o conteudo dos seguintes campos
  
  protected
  def authorize
    if Rails.env=="production" or Rails.env=="staging"
      unless Admin.find_by_id(session[:admin_id])
        flash[:notice] = "Autentique-se!"
        redirect_to :controller => 'admin', :action => 'login'
      end
    end
  end
  
  def setSEO
    @description = "Compre ingressos para teatros, shows e espetáculos em São Paulo e nas principais cidades do Brasil. Confira a programação completa das atrações"
    @keywords = "compreingressos, compre ingressos, ingressos, compra ingressos, venda ingressos, teatro, teatro ingressos, teatro sao paulo, ingressos shows, shows, ingressos espetaculos, espetaculos"
  end
  
  def mailchimpecommerce360
    if params.has_key?(:mc_cid) and params.has_key?(:mc_eid)
      cookies[:mc_cid] = {
        :value => params[:mc_cid],
        :expires => 30.day.from_now,
        :domain => '.compreingressos.com'
      }
      cookies[:mc_eid] = {
        :value => params[:mc_eid],
        :expires => 30.day.from_now,
        :domain => '.compreingressos.com'
      }
    end
  end
  
  def check_desktop_version
    if params[:desktop]=='true'
      session[:desktop] = 1
    elsif params[:desktop]=='false'
      session[:desktop] = 0
    end
    if !params[:app].blank?
      session[:app] = params[:app]
    end
  end
  
  def check_baixeapp
    if request.user_agent =~ /Mobile|webOS/
      if params[:controller]=="compreingressos" and params[:action]=="index"
        redirect_to "/espetaculos?auto=true"
      else
        if params[:controller]=="compreingressos" and params[:action]=="app"
        elsif cookies[:baixeapp].blank?
          @baixeapp = 1
        end
      end
    end
  end

  def set_csp
    response.headers['Content-Security-Policy'] = "script src 'self' #{ENVIRONMENT_VARS['host']};  media src 'none'; img src ; default src 'self' #{ENVIRONMENT_VARS['host']}"
  end

  def set_publicidade
    @publicidade = Publicidade.first(:conditions => ["status = true AND (? between data_inicio AND data_fim)", Date.today], :order => "RAND()")
  end
#  def check_location
#    if session[:desktop]==1
#      if session[:cidade].blank?
#        # Baixar novas bases no http://dev.maxmind.com/geoip/legacy/geolite/ GeoLite City (Gzip)
#        require 'geoip'
#        if Rails.env=="production" or Rails.env=="staging"
#          uip = request.remote_ip
#        else
#          uip = '151.38.39.114' # IP da italia
#          uip = '186.231.147.13' # IP do Brasil
#        end
#        local = GeoIP.new(Rails.root.join("db/GeoLiteCity.dat")).city(uip)
#        if local && !local.city_name.blank?
#          logger.warn("Cidade: #{local.city_name}")
#          #session[:cidade] = local.city_name
#        end
#        logger.warn("\n\n\n\n\n #{local.inspect} \n\n\n\n\n ")
#      else
#        #logger.warn("Session cidade já definida como: #{session[:cidade]}")
#      end
#    end
#  end
end