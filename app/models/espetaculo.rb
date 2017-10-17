class Espetaculo < ActiveRecord::Base
  KEY_FACEBOOK_APP = "5092c5225f46a69e6519315850882ebe"
  KEY_TOKECOMPRE_APP = "8435D5115e46a70i6648715850882eus"
  KEY_PAINEIS_TEATROS = "b12fa2e6c650eafe870209e7eadb13f2"
  ABAS = [
    ['Vazio',0],
    ['Sinopse',1],
    ['Informacoes',2],
    ['Fotos',3],
    ['Videos',4]
  ]
  RELEVANCIAS = [
    [1,1],
    [2,2],
    [3,3],
    [4,4],
    [5,5]
  ]
  BOTOES = [
    ['Claro',0],
    ['Escuro',1],
  ]

  attr_accessor :datas
  attr_accessor :g_price
  attr_accessor :g_sale_price
  
  belongs_to :teatro
  acts_as_mappable :through => :teatro
  
  belongs_to :classificacao
  belongs_to :genero
  has_one :cidade, :through => :teatro
  has_one :proximo_horario, :class_name => 'Horario', :conditions => ["horarios.data >= ?", DateTime.now()], :order => :data
  has_many :galerias, :dependent => :destroy
  has_many :imagems, :as => :asset, :dependent => :destroy
  has_many :entradas, :as => :asset, :dependent => :destroy
  has_many :videos, :as => :asset, :dependent => :destroy
  has_many :espetaculos_homes
  has_many :homes, :through => :espetaculos_homes, :order => "ordem ASC"
  has_many :home_modulo_espetaculos, :dependent => :destroy
  has_many :horarios, :order => :data
  has_many :horarios_disponiveis, :class_name => 'Horario', :conditions => ["horarios.data >= ?", DateTime.now()], :order => :data
  has_many :pacotes_espetaculos, :order => :data
  has_and_belongs_to_many :pagina_especiais
  has_and_belongs_to_many :pagina_especial_filtros

  validates_presence_of :nome, :relevancia, :teatro_id, :keywords
  validates_presence_of :aba_inicial, :cor_dos_botoes, :cor_de_fundo, :altura_de_inicio, :altura_de_inicio_mobile, :cor_do_texto_do_cabecalho, :cor_do_link_do_cabecalho, :cor_da_borda_das_imagens, :cor_de_fundo_do_box, :cor_do_texto_do_box, :cor_do_link_do_box, :if => :especial?
  validates_inclusion_of :relevancia, :in => RELEVANCIAS.map{|disp, value| value}
  validates_inclusion_of :cor_dos_botoes, :in => BOTOES.map{|disp, value| value}, :if => :especial?
  validates_inclusion_of :aba_inicial, :in => ABAS.map{|disp, value| value}, :if => :especial?
  
  validates_attachment_content_type :img_principal, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
  #validates_attachment_size :img_principal, :less_than => 300.kilobytes, :message => "o tamanho da imagem excede o máximo de 300kb"
  validates_attachment_presence :img_principal, :message => "precisa ser enviada"
  has_attached_file :img_principal,
                    :path => ":rails_root/public/images/espetaculos/:id/princial.:extension",
                    :url => "/images/espetaculos/:id/princial.:extension"

  validates_attachment_content_type :img_miniatura, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
  validates_attachment_presence :img_miniatura, :message => "precisa ser enviada"
  has_attached_file :img_miniatura,
                    :styles => {:miniatura => {:geometry => '160', :format => 'jpg'}, :miniatura2x => {:geometry => '320', :format => 'jpg'}},
                    :path => ":rails_root/public/images/espetaculos/:id/:style.:extension",
                    :url => "/images/espetaculos/:id/:style.:extension",
                    :default_url => "/images/espetaculos/padrao/miniatura.jpg"
                    
  validates_attachment_content_type :fundo, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG", :if => :especial?
  #validates_attachment_size :fundo, :less_than => 600.kilobytes, :message => "o tamanho da imagem excede o máximo de 600kb"
  has_attached_file :fundo,
                    :path => ":rails_root/public/images/espetaculos/:id/fundo.:extension",
                    :url => "/images/espetaculos/:id/fundo.:extension",
                    :use_timestamp => false
  #QUERY TO MEASURE THE SIZE OF THE BACKGROUND IMAGES IN SPECIAL SHOWS
  #SELECT e.id, e.nome, concat(round(round((e.fundo_file_size/1000))/1000,2),'mb') as img, t.nome  FROM espetaculos AS e, teatros AS t WHERE e.teatro_id = t.id AND especial = 1 ORDER BY e.fundo_file_size  DESC
  
  validates_attachment_content_type :img_destaque, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
  has_attached_file :img_destaque,
                    :path => ":rails_root/public/images/espetaculos/:id/destaque.:extension",
                    :url => "/images/espetaculos/:id/destaque.:extension"
      
  accepts_nested_attributes_for :galerias, :allow_destroy => true
  accepts_nested_attributes_for :imagems, :allow_destroy => true
  accepts_nested_attributes_for :entradas, :allow_destroy => true
  accepts_nested_attributes_for :videos, :allow_destroy => true

  before_save :send_miniatura_ftp, :strip_nome_espetaculo, :update_horario_cache
  after_save :destroy_original
  after_post_process :save_image_dimensions
  after_commit :reset_cache

  # define scopes to filter Spetacles based on Status, Gender, City and Expiration Date
  named_scope :ativo, :conditions => { :ativo => true }
  named_scope :nao_expirado, :conditions => ["data_maxima >= ?", DateTime.now.to_date]
  named_scope :por_genero, lambda { |gender| { :joins => :genero, :conditions => { :generos => { :nome => gender } } } }
  named_scope :por_cidade, lambda { |city| { :joins => { :teatro => :cidade }, :conditions => { :cidades => { :nome => city } } } }
  named_scope :por_conjunto_cidade, lambda { |city_region| { :joins => { :teatro => :cidade }, :group => 'espetaculos.id', :conditions => ["cidades.id IN (?)", city_region] } }
  named_scope :ordenar_por, lambda { |order| { :joins => :horarios, :group => :id, :conditions => ["horarios.data >= ?", DateTime.now], :order => order } }

  # Salva a altura da miniatura para o plugin que embaralha os espetaculos calcular a altura correta se não
  # ele fica recalculando após carregar cada imagem causando erros visuais momentaneos no browser do usuario
  def save_image_dimensions
    # Lembrando que para a miniatura não existe outros tamanhos de imagem além do original
    if img_miniatura.queued_for_write[:original]
      geo = Paperclip::Geometry.from_file(img_miniatura.queued_for_write[:original])
      self.img_miniatura_height = geo.height.to_i
    end
  end
  
  def reset_cache
    Rails.cache.delete("views/menu")
    Rails.cache.delete("views/espetaculos")
    # Verifica se o arquivo original da miniatura foi enviado, caso sim ele salva a altura da imagem.
    Rails.cache.delete("views/espetaculos/alfabetica")
    Rails.cache.delete("views/espetaculos/data")
    Rails.cache.delete("views/espetaculos/#{self.cidade.nome.parameterize}")
    Rails.cache.delete("views/espetaculos/#{self.cidade.nome.parameterize}/alfabetica")
    Rails.cache.delete("views/espetaculos/#{self.cidade.nome.parameterize}/data")
    Rails.cache.delete("views/espetaculos/#{self.genero.nome.parameterize}")
    Rails.cache.delete("views/espetaculos/#{self.genero.nome.parameterize}/alfabetica")
    Rails.cache.delete("views/espetaculos/#{self.genero.nome.parameterize}/data")
    Rails.cache.delete("views/espetaculos/#{self.cidade.nome.parameterize}/#{self.genero.nome.parameterize}")
    Rails.cache.delete("views/espetaculos/#{self.cidade.nome.parameterize}/#{self.genero.nome.parameterize}/alfabetica")
    Rails.cache.delete("views/espetaculos/#{self.cidade.nome.parameterize}/#{self.genero.nome.parameterize}/data")
    Rails.cache.delete("views/teatros")
    Rails.cache.delete("views/teatros/alfabetica")
    Rails.cache.delete("views/teatros/#{self.cidade.nome.parameterize}")
    Rails.cache.delete("views/teatros/#{self.cidade.nome.parameterize}/alfabetica")
  end
  
  def destroy_original
    if !self.img_miniatura.path.blank?
      if FileTest.exists?(self.img_miniatura.path)
        File.unlink(self.img_miniatura.path)
      end
    end
  end
  
  def send_miniatura_ftp
    if self.cc_id and Rails.env=="production"
      begin
        require 'net/ftp'

        # FTP 1
        ftp1 = Net::FTP.new
        ftp1.connect(ENVIRONMENT_VARS['ftp_compra_host1'],ENVIRONMENT_VARS['ftp_compra_port1'])
        ftp1.passive = true
        ftp1.login(ENVIRONMENT_VARS['ftp_compra_username1'],ENVIRONMENT_VARS['ftp_compra_password1'])
        ftp1.chdir(ENVIRONMENT_VARS['ftp_compra_images_dir1'])
        
        # FTP 2
        ftp2 = Net::FTP.new
        ftp2.connect(ENVIRONMENT_VARS['ftp_compra_host2'],ENVIRONMENT_VARS['ftp_compra_port2'])
        ftp2.passive = true
        ftp2.login(ENVIRONMENT_VARS['ftp_compra_username2'],ENVIRONMENT_VARS['ftp_compra_password2'])
        ftp2.chdir(ENVIRONMENT_VARS['ftp_compra_images_dir2'])
        
        # FTP 3
        ftp3 = Net::FTP.new
        ftp3.connect(ENVIRONMENT_VARS['ftp_compra_host3'],ENVIRONMENT_VARS['ftp_compra_port3'])
        ftp3.passive = true
        ftp3.login(ENVIRONMENT_VARS['ftp_compra_username3'],ENVIRONMENT_VARS['ftp_compra_password3'])
        ftp3.chdir(ENVIRONMENT_VARS['ftp_compra_images_dir3'])
        
        arquivo = "#{RAILS_ROOT}/public/images/espetaculos/#{self.id}/miniatura.jpg"
        if File.exist?(arquivo)
          #logger.info "\n\n\n###\nUPLOADING"
          ftp1.putbinaryfile(arquivo, "#{self.cc_id}.jpg", Net::FTP::DEFAULT_BLOCKSIZE)
          ftp2.putbinaryfile(arquivo, "#{self.cc_id}.jpg", Net::FTP::DEFAULT_BLOCKSIZE)
          ftp3.putbinaryfile(arquivo, "#{self.cc_id}.jpg", Net::FTP::DEFAULT_BLOCKSIZE)
          #logger.info "Images uploaded\n###\n\n\n"
        else
          #logger.info "\n\n\n###\nIMAGE DOESNT EXIST\n###\n\n\n"
        end
        ftp1.close
        ftp2.close
        ftp3.close
      rescue Exception => e
        errors.add(:img_miniatura, "Erro ao enviar imagem para o servidor da C&C. Mensagem: #{e.message}")
        return false # Sem o return o rails ignora o erro adicionado
      end
    end
  end
  
  def strip_nome_espetaculo
    self.nome = self.nome.strip
  end
  
  def update_horario_cache
    self.horario_cache = DateTime.now
  end
  
  # Sphinx index
  # Usano na busca geral do site
  define_index 'ativo' do
    indexes :nome
    indexes :keywords
    indexes teatro.nome, :as => :teatro_nome
    indexes teatro.endereco, :as => :endereco
    indexes teatro.bairro, :as => :bairro
    indexes teatro.cidade.nome, :as => :cidade
    indexes teatro.cidade.estado, :as => :estado
    indexes genero.nome, :as => :genero
    indexes entradas.valor, :as => :entradas
    indexes entradas.atributo, :as => :entradas_atributo
    where "espetaculos.ativo = 1 AND espetaculos.privado = 0"
    has teatro_id
  end
  
  # Usado nas busca das páginas privadas
  define_index 'privado' do
    indexes :nome
    indexes :keywords
    indexes teatro.nome, :as => :teatro_nome
    indexes teatro.endereco, :as => :endereco
    indexes teatro.bairro, :as => :bairro
    indexes teatro.cidade.nome, :as => :cidade
    indexes teatro.cidade.estado, :as => :estado
    indexes genero.nome, :as => :genero
    indexes entradas.valor, :as => :entradas
    indexes entradas.atributo, :as => :entradas_atributo
    where "espetaculos.ativo = 1"
    #where "(espetaculos.ativo = 1 OR espetaculos.privado = 1)"
  end
  
  # URL amigavel
  def to_param
    retorno = nome.downcase
    retorno = retorno.gsub('.','').gsub(',','').gsub('º','').gsub('ª','').gsub('"','').gsub('(','').gsub(')','').gsub('#','').gsub("'",'').gsub("’",'').gsub('?','').gsub('!','').gsub(/\r/,'').gsub(/\n/,'-').gsub('/','-').gsub(' ','-').gsub('–','-').gsub('–','-').gsub('&','e').gsub('+','').gsub('“','').gsub('”','')
    retorno = retorno.gsub('á','a').gsub('â','a').gsub('ã','a').gsub('à','a').gsub('é','e').gsub('É','e').gsub('ê','e').gsub('í','i').gsub('î','i').gsub('ï','i').gsub('ó','o').gsub('ô','o').gsub('õ','o').gsub('ú','u').gsub('ç','c').gsub('$','s').gsub('---','-').gsub('--','-')
    retorno = "#{id}-"+retorno
  end
  
  # MISTÉRIO - Ainda não descobri de onde vem
  def self.random(max_elements,exclude_id = nil)
    unless (exclude_id)
      ids = find( :all,:conditions => { :ativo => true}, :select => 'id' ).map( &:id )
    else
      # MUDAR A LINHA ABAIXO PARA MYSQL
      ids = find( :all, :conditions => "ativo=true AND id <> #{exclude_id}", :select => 'id' ).map( &:id )
    end
    return nil if ids.empty?
    max_index = ids.size > max_elements ? max_elements : ids.size
    
    objects = find( (1..max_index).map { ids.delete_at( ids.size * rand ) } )
    return objects.sort_by{rand}
  end

  def after_find
    begin
      set_price_for_criteo
    rescue
      return
    end
  end

  private
    def set_price_for_criteo
      price = []
      self.preco.gsub(/\d+,\d+/) { |match| price << match.gsub(',', '.').to_f }
      price.sort!
      self.g_price = price.last
      self.g_sale_price = price.first
    end
end
