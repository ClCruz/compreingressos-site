class PaginaEspecial < ActiveRecord::Base
  TIPOS = [
    ["Normal",1],
    ["Privada",2]#,
    #["Turnê",3]
  ]
  ORGANIZADOPOR = [
    ["Destaques",1],
    ["Ordem alfabética",2],
    ["Próximas apresentações",3]
  ]
  TIPOBOTAO = [
    ["Comprar",1],
    ["Saiba mais",2]
  ]
  
  
  has_and_belongs_to_many :espetaculos
  
  
  validates_presence_of :tipo, :nome, :url, :cor_de_fundo, :altura_de_inicio_da_listagem, :cor_de_fundo_do_box, :cor_do_texto_do_box, :cor_do_link_do_box, :cor_da_borda_do_espetaculo
  validates_uniqueness_of :url
  validates_format_of :url, :with => /^[a-z\d_-]+$/, :message => "só pode conter letras minúsculas, underlines e traços"
  validates_inclusion_of :tipo, :in => TIPOS.map{|disp, value| value}
  validates_inclusion_of :organizado_por, :in => ORGANIZADOPOR.map{|disp, value| value}
  validates_inclusion_of :tipo_de_botao, :in => TIPOBOTAO.map{|disp, value| value}
  validate :extras_validacoes
  validates_attachment_content_type :logo, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
  has_attached_file :logo,
                    :path => ":rails_root/public/images/paginas_especiais/:id/logo.:extension",
                    :url => "/images/paginas_especiais/:id/logo.:extension"  
  validates_attachment_content_type :imagem, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
  validates_attachment_presence :imagem, :message => "precisa ser enviada"
  has_attached_file :imagem,
                    :path => ":rails_root/public/images/paginas_especiais/:id/visor.:extension",
                    :url => "/images/paginas_especiais/:id/visor.:extension"
  
  private
  def extras_validacoes
    # Testa se a cor do header foi preenchida quando a página é privada
    if self.tipo==2 and self.cor_do_header.blank?
      errors.add(:cor_do_header, I18n.t("activerecord.errors.messages.blank"))
    end
    
    # Testa se o campo de aviso foi preenchido quando o botao é saiba mais
    #if self.tipo_de_botao==2 and self.saiba_mais_aviso.blank?
    #  errors.add(:saiba_mais_aviso, I18n.t("activerecord.errors.messages.blank"))
    #end
  end
end
