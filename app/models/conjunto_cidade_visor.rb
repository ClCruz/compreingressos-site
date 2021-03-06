class ConjuntoCidadeVisor < ActiveRecord::Base
	belongs_to :conjunto_cidades

	validates_presence_of :link
	validates_attachment_content_type :imagem, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
	validates_attachment_presence :imagem, :message => "precisa ser enviada"
	has_attached_file :imagem,
	                :path => ":rails_root/public/images/conjunto_cidade_visores/:id/visor.:extension",
	                :url => "/images/conjunto_cidade_visores/:id/visor.:extension"
	                
	before_create :definir_ordem
	before_save :normaliza

	def normaliza
	self.link = self.link.gsub('http://www.compreingressos.com','').gsub('http://compreingressos.com','').gsub('https://www.compreingressos.com','').gsub('https://compreingressos.com','').gsub('www.compreingressos.com','')
	end

	def definir_ordem
	obj = ConjuntoCidadeVisor.find(:last, :order => :ordem)
	if obj
	  self.ordem = obj.ordem+1
	else
	  self.ordem = 0
	end
end
end
