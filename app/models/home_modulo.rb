class HomeModulo < ActiveRecord::Base
  has_many :home_modulo_espetaculos, :dependent => :destroy, :order => :ordem
  accepts_nested_attributes_for :home_modulo_espetaculos, :allow_destroy => true
  
  TIPO = [
    ["1 coluna",1],
    ["2 colunas",2],
    ["Banner de 1 coluna",3],
    ["Banner de 2 colunas",4]
  ]
  
  validate :extras_validacoes
  validates_presence_of :entrada, :saida
  validates_inclusion_of :tipo, :in => TIPO.map{|disp, value| value}
  validates_attachment_content_type :imagem, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
  validates_attachment_presence :imagem, :message => "precisa ser enviada", :if => :valida_imagem
  has_attached_file :imagem,
                    :path => ":rails_root/public/images/home_banners/:id/banner.:extension",
                    :url => "/images/home_banners/:id/banner.:extension"
  
  after_post_process :save_image_dimensions
  before_create :definir_ordem
  before_save :normaliza
  after_commit :reset_cache
  
  
  private
  def normaliza
    unless self.link.blank?
      self.link = self.link.gsub('http://www.compreingressos.com','').gsub('http://compreingressos.com','').gsub('https://www.compreingressos.com','').gsub('https://compreingressos.com','').gsub('www.compreingressos.com','')
    end
  end
  
  def reset_cache
    Rails.cache.delete('views/home')
  end
  
  def definir_ordem
    obj = HomeModulo.find(:last, :order => 'ordem')
    #logger.info(obj.ordem)
    if obj
      self.ordem = obj.ordem+1
    else
      self.ordem = 0
    end
  end
  
  def extras_validacoes
    if self.tipo==1 or self.tipo==2
      if self.titulo.blank?
        errors.add(:titulo, I18n.t("activerecord.errors.messages.blank"))
      end
      if self.exibir.blank?
        errors.add(:exibir, I18n.t("activerecord.errors.messages.blank"))
      end
    end
  end
  
  def valida_imagem
    if self.tipo==3 or self.tipo==4
      true
    else
      false
    end
  end
  
  # Salva a altura do banner para o plugin que embaralha os módulos calcular a altura correta
  def save_image_dimensions
    if imagem.queued_for_write[:original]
      geo = Paperclip::Geometry.from_file(imagem.queued_for_write[:original])
      self.imagem_altura = geo.height.to_i
    end
  end
end
