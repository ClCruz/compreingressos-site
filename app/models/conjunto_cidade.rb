class ConjuntoCidade < ActiveRecord::Base
	has_and_belongs_to_many :cidades
	has_many :conjunto_cidade_visores, :order => 'ordem', :dependent => :destroy

	accepts_nested_attributes_for :conjunto_cidade_visores, :allow_destroy => true

	validates_attachment_content_type :imagem_de_fundo, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
	has_attached_file :imagem_de_fundo,
                    :path => ":rails_root/public/images/conjunto_cidades/:id/background.:extension",
                    :url => "/images/conjunto_cidades/:id/background.:extension"

	attr_accessor :total
end
