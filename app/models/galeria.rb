class Galeria < ActiveRecord::Base
  belongs_to :espetaculo
  
  #validates_presence_of :espetaculo_id
  
  validates_attachment_content_type :imagem, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
  validates_attachment_presence :imagem, :message => "precisa ser enviada"
  has_attached_file :imagem,
                    :styles => {:big => {:geometry => '465x274>#', :format => 'png'}, :thumb => {:geometry => '150x88>#', :format => 'png'}},
                    :convert_options => {:big => "-quality 80", :thumb => "-quality 70"},
                    :path => ":rails_root/public/images/espetaculos/:espetaculo_id/:id-:style.:extension",
                    :url => "/images/espetaculos/:espetaculo_id/:id-:style.:extension"
  Paperclip.interpolates :espetaculo_id do |attachment, style|
    attachment.instance.espetaculo.id
    #attachment.instance.espetaculo_id
  end
  
  before_create :definir_ordem
  after_save :destroy_original
  
  
  def destroy_original
    if !self.imagem.path.blank?
      if FileTest.exists?(self.imagem.path)
        File.unlink(self.imagem.path)
      end
    end
  end
  
  def definir_ordem
    obj = Galeria.find(:last, :conditions => { :espetaculo_id => self.espetaculo_id }, :order => 'ordem')
    if obj
      self.ordem = obj.ordem + 1
    else
      self.ordem = 0
    end
  end
end
