class Publicidade < ActiveRecord::Base

	validates_presence_of :nome
	validates_attachment_content_type :imagem, 
                                    :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], 
                                    :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
	has_attached_file :imagem,
                    :path => ":rails_root/public/images/publicidades/:id/publicidade.:extension",
                    :url => "/images/publicidades/:id/publicidade.:extension"
end
