class Visor < ActiveRecord::Base
  KEY_TOKECOMPRE_APP = "8435D5115e46a70i6648715850882eus"
  
  validates_presence_of :link, :descricao, :data_de_expiracao
  
  validates_attachment_content_type :imagem, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
  validates_attachment_presence :imagem, :message => "precisa ser enviada"
  has_attached_file :imagem,
                    :path => ":rails_root/public/images/visores/:id/visor.:extension",
                    :url => "/images/visores/:id/visor.:extension"
  
  #validates_attachment_content_type :imagem_mobile, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
  #validates_attachment_presence :imagem_mobile, :message => "precisa ser enviada"
  has_attached_file :imagem_mobile,
                    #:styles => {:visor_mobile => {:geometry => '1920x525', :format => 'jpg'}, :mobile_app => {:geometry => '1242x690#', :format => 'jpg'}},
                    #:path => ":rails_root/public/images/visores/:id/:style.:extension",
                    #:url => "/images/visores/:id/:style.:extension"
                    :path => ":rails_root/public/images/visores/:id/visor_mobile.:extension",
                    :url => "/images/visores/:id/visor_mobile.:extension"
                    
  before_create :definir_ordem
  before_save :normaliza
  after_commit :reset_cache
  
  def normaliza
    self.link = self.link.gsub('http://www.compreingressos.com','').gsub('http://compreingressos.com','').gsub('https://www.compreingressos.com','').gsub('https://compreingressos.com','').gsub('www.compreingressos.com','')
  end
  
  def definir_ordem
    obj = Visor.find(:last, :order => 'visores.order')
    if obj
      self.order = obj.order+1
    else
      self.order = 0
    end
  end
  
  def reset_cache
    Rails.cache.delete("views/home")
    Rails.cache.delete("views/espetaculos")
  end
end
