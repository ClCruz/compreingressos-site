class PaginaDePacote < ActiveRecord::Base
  has_many :pacotes, :order => :ordem
  
  validates_presence_of :nome, :url, :altura_de_inicio_da_listagem
  validates_uniqueness_of :url
  validates_format_of :url, :with => /^[a-z\d_-]+$/, :message => "só pode conter letras minúsculas, underlines e traços"  
  
  validates_attachment_content_type :imagem, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
  validates_attachment_presence :imagem, :message => "precisa ser enviada"
  has_attached_file :imagem,
                    :path => ":rails_root/public/images/pagina_de_pacotes/:id/visor.:extension",
                    :url => "/images/pagina_de_pacotes/:id/visor.:extension"
end
