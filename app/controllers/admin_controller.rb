class AdminController < ApplicationController
  before_filter :authorize, :except => [:login]
  newrelic_ignore_apdex
  layout 'compreingressos_antigo'
  
  def login
    flash[:notice] = "Bem-vindo administrador!"
    if Rails.env=="production" or Rails.env=="staging"
      if request.post?
        user = Admin.authenticate(params[:nome],params[:senha])
        if user
          session[:admin_id] = user.id
          redirect_to(:action => :index)
        end
      end
    else
      session[:admin_id] = 1
      redirect_to(:action => :index)
    end
    flash[:notice] = "Usuário/senha inválido(s)"
  end

  def index
    # Delete old sessions
    sql = "DELETE FROM sessions WHERE updated_at < '#{DateTime.now-48.hours}';"
    ActiveRecord::Base.connection.execute(sql) if Rails.env=="production"
  end

  def logout
    session[:admin_id] = nil 
    flash[:notice] = "Desconectado! Tenha um bom dia!" 
    redirect_to(:controller => :compreingressos)
  end

end
