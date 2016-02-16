class Teatro < ActiveRecord::Base
  validates_presence_of :cidade_id, :nome, :endereco, :lotacao, :telefone
  
  attr_accessor :ocultar_teatro, :ocultar_cidade, :ocultar_genero
  geocoded_by :endereco_completo
  after_validation :geocode, :if => Proc.new{ |a| a.endereco_changed? || a.bairro_changed? || a.cidade_id_changed? }
  acts_as_mappable :default_units => :kms, 
                   :default_formula => :sphere, 
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude
  
  belongs_to :cidade
  has_many :imagems, :as => :asset, :dependent => :destroy
  has_many :entradas, :as => :asset, :dependent => :destroy
  has_many :espetaculos, :order => :nome
  has_many :videos, :as => :asset, :dependent => :destroy
  has_many :teatro_imagens, :order => :ordem, :dependent => :destroy
  
  accepts_nested_attributes_for :imagems, :allow_destroy => true
  accepts_nested_attributes_for :entradas, :allow_destroy => true
  accepts_nested_attributes_for :entradas, :allow_destroy => true
  accepts_nested_attributes_for :videos, :allow_destroy => true
  accepts_nested_attributes_for :teatro_imagens, :allow_destroy => true
  
  ABAS = ['mapa_de_plateia','ficha_tecnica','fotos','videos']
  
  RELEVANCIAS = [
    [1,1],
    [2,2],
    [3,3],
    [4,4],
    [5,5]
  ]

  ORGANIZADOPOR = [
    ["Destaques",1],
    ["Ordem alfabética",2],
    ["Próximas apresentações",3]
  ]
  
  validates_inclusion_of :ordenacao_dos_espetaculos, :in => ORGANIZADOPOR.map{|disp, value| value}
  validates_attachment_content_type :imagem, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
  has_attached_file :imagem,
                    :styles => {:big => {:geometry => '160x160#', :format => 'jpg'}, :thumb => {:geometry => '72x72#', :format => 'jpg'}},
                    :path => ":rails_root/public/images/teatros/:id/:style.:extension",
                    :url => "/images/teatros/:id/:style.:extension",
                    :default_url => "/images/teatros/padrao/miniatura.jpg"
                    
  validates_attachment_content_type :imagem_de_fundo, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
  has_attached_file :imagem_de_fundo,
                    :path => ":rails_root/public/images/teatros/:id/imagem_de_fundo.:extension",
                    :url => "/images/teatros/:id/imagem_de_fundo.:extension"
                    
  validates_attachment_content_type :mapa_de_plateia, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
  #validates_attachment_presence :mapa_de_plateia, :message => "precisa ser enviado"
  has_attached_file :mapa_de_plateia,
                    :path => ":rails_root/public/images/teatros/:id/mapa_de_plateia.:extension",
                    :url => "/images/teatros/:id/mapa_de_plateia.:extension"
  
  
  before_save :strip_nome_teatro                  
  after_save :destroy_original  
  after_commit :reset_cache
  
  def destroy_original
    if !self.imagem.path.blank?
      if FileTest.exists?(self.imagem.path)
        File.unlink(self.imagem.path)
      end
    end
  end
  
  def reset_cache
    Rails.cache.delete("views/teatros")
    Rails.cache.delete("views/teatros/alfabetica")
    Rails.cache.delete("views/teatros/#{self.cidade.nome.parameterize}")
    Rails.cache.delete("views/teatros/#{self.cidade.nome.parameterize}/alfabetica")
  end
  
  # URL amigavel
  def to_param
    retorno = nome.downcase
    retorno = retorno.gsub('.','').gsub(',','').gsub('º','').gsub('ª','').gsub('"','').gsub('(','').gsub(')','').gsub('#','').gsub("'",'').gsub("’",'').gsub('?','').gsub('!','').gsub(/\r/,'').gsub(/\n/,'-').gsub('/','-').gsub(' ','-').gsub('–','-').gsub('–','-').gsub('&','e').gsub('+','').gsub('“','').gsub('”','')
    retorno = retorno.gsub('á','a').gsub('â','a').gsub('ã','a').gsub('à','a').gsub('é','e').gsub('É','e').gsub('ê','e').gsub('í','i').gsub('î','i').gsub('ï','i').gsub('ó','o').gsub('ô','o').gsub('õ','o').gsub('ú','u').gsub('ç','c').gsub('$','s').gsub('---','-').gsub('--','-')
    retorno = "#{id}-"+retorno
  end
  
  def strip_nome_teatro
    self.nome = self.nome.strip
  end
  
  def endereco_completo
    "#{self.endereco}, #{self.cidade.nome} - #{self.cidade.estado}, Brasil"
  end
  
  # MISTÉRIO - Ainda não descobri de onde vem
  def self.random(max_elements,exclude_id = nil)
    unless (exclude_id)
      ids = find( :all, :select => 'id' ).map( &:id )
    else
      # MUDAR A LINHA ABAIXO PARA MYSQL
      ids = find( :all, :conditions => "id <> #{exclude_id}", :select => 'id' ).map( &:id )
    end
    return nil if ids.empty?
    max_index = ids.size > max_elements ? max_elements : ids.size
    objects = find( (1..max_index).map { ids.delete_at( ids.size * rand ) } )
    return objects.sort_by{rand}
  end
end