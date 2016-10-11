class Cidade < ActiveRecord::Base
  validates_presence_of :nome, :estado
  
  has_many :teatros, :order => 'teatros.nome'
  has_many :espetaculos, :through => :teatros, :order => 'nome', :conditions => {:ativo => true}
  has_one :home
  has_one :visor, :through => :home
  has_one :outras_localidade, :through => :home
  has_many :pontosdevenda, :order => :local
  has_many :cidade_visores, :order => 'ordem', :dependent => :destroy
  has_and_belongs_to_many :conjunto_cidades
  
  accepts_nested_attributes_for :cidade_visores, :allow_destroy => true
  
  
  validates_attachment_content_type :imagem_de_fundo, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
  has_attached_file :imagem_de_fundo,
                    :path => ":rails_root/public/images/cidades/:id/background.:extension",
                    :url => "/images/cidades/:id/background.:extension"
  
  before_save :uppercaseestado
  
  def uppercaseestado
    self.estado = self.estado.upcase
  end
end
