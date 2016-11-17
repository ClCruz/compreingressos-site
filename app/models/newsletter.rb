class Newsletter < ActiveRecord::Base

	validates_attachment_content_type :img_destaque, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
  has_attached_file :img_destaque,
                    :path => ":rails_root/public/images/newsletters/:id/destaque.:extension",
                    :url => "/images/newsletters/:id/destaque.:extension"
end
