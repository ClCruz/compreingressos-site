class HomeBackgroundController < ApplicationController
  before_filter :authorize
  newrelic_ignore_apdex
  layout 'compreingressos_antigo'
  
  # GET /homes
  # GET /homes.xml
  def index
    @hb = HomeBackground.find(1)
  end

  # GET /homes/1
  # GET /homes/1.xml
  def gravar
    if(params.has_key?(:form))
      # Exclui primeiro se existir alguma imagem
      arquivo = Dir.glob("#{RAILS_ROOT}/public/images/home_bg/*").first.to_s
      File.delete(arquivo) if File.exist?(arquivo)
      
      # Seta o local de gravacao do arquivo com nome e extensao correta
      path = File.join(Rails.root,"public/images/home_bg/bg#{File.extname(params[:form][:imagem].original_filename)}")
      # Grava no local indicado
      File.open(path, "wb") do |f| 
        f.write(params[:form][:imagem].read)
      end
    end
    
    #Atualiza BG Color
    hb = HomeBackground.find(1)
    hb.bgcolor = params[:bgcolor]
    hb.cor_de_texto = params[:cor_de_texto]
    hb.esquerda_blank = params[:esquerda_blank].blank? ? 0:1
    hb.esquerda_link = params[:esquerda_link]
    hb.direita_blank = params[:direita_blank].blank? ? 0:1
    hb.direita_link = params[:direita_link]
    hb.save
    redirect_to("/home_background/")
  end
  
  def excluir
    arquivo = Dir.glob("#{RAILS_ROOT}/public/images/home_bg/*").first.to_s
    File.delete(arquivo) if File.exist?(arquivo)
    redirect_to("/home_background/")
  end
end