class Pacote < ActiveRecord::Base
  has_many :pacotes_espetaculos, :order => :data
  belongs_to :pagina_de_pacote
  has_and_belongs_to_many :pacote_filtros
  
  accepts_nested_attributes_for :pacotes_espetaculos, :allow_destroy => true
  
  validates_presence_of :nome
  
  
  validates_attachment_content_type :imagem, :content_type => ["image/x-png", "image/pjpeg", "image/jpg", "image/jpeg", "image/png", "image/gif"], :message => "deve estar em algum dos seguintes formatos: JPG, GIF ou PNG"
  validates_attachment_presence :imagem, :message => "precisa ser enviada"
  has_attached_file :imagem,
                    :path => ":rails_root/public/images/pacotes/:pagina_de_pacote_id/:id.:extension",
                    :url => "/images/pacotes/:pagina_de_pacote_id/:id.:extension"
  Paperclip.interpolates :pagina_de_pacote_id do |attachment, style|
    attachment.instance.pagina_de_pacote_id
  end
  
  
  before_create :definir_ordem
  before_save :send_miniatura_ftp
  
  def definir_ordem
    obj = Pacote.find(:last, :conditions => {:pagina_de_pacote_id => self.pagina_de_pacote_id}, :order => :ordem)
    if !obj.blank?
      self.ordem = obj.ordem+1
    else
      self.ordem = 0
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
        #ftp3 = Net::FTP.new
        #ftp3.connect(ENVIRONMENT_VARS['ftp_compra_host3'],ENVIRONMENT_VARS['ftp_compra_port3'])
        #ftp3.passive = true
        #ftp3.login(ENVIRONMENT_VARS['ftp_compra_username3'],ENVIRONMENT_VARS['ftp_compra_password3'])
        #ftp3.chdir(ENVIRONMENT_VARS['ftp_compra_images_dir3'])

        arquivo = "#{RAILS_ROOT}/public/images/pacotes/#{self.pagina_de_pacote_id}/#{self.id}.jpg"
        if File.exist?(arquivo)
          #logger.info "\n\n\n###\nUPLOADING"
          ftp1.putbinaryfile(arquivo, "#{self.cc_id}.jpg", Net::FTP::DEFAULT_BLOCKSIZE)
          ftp2.putbinaryfile(arquivo, "#{self.cc_id}.jpg", Net::FTP::DEFAULT_BLOCKSIZE)
          #ftp3.putbinaryfile(arquivo, "#{self.cc_id}.jpg", Net::FTP::DEFAULT_BLOCKSIZE)
          #logger.info "Images uploaded\n###\n\n\n"
        else
          #logger.info "\n\n\n###\nIMAGE DOESNT EXIST\n###\n\n\n"
        end
        ftp1.close
        ftp2.close
        #ftp3.close
      rescue Exception => e
        errors.add(:imagem, "Erro ao enviar imagem para o servidor da C&C. Mensagem: #{e.message}")
        return false # Sem o return false o rails ignora o erro adicionado
      end
    end

#    if self.cc_id
#      require 'net/ftp'
#      ftp = Net::FTP.new
#      ftp.connect(ENVIRONMENT_VARS['ftp_compra_host'],ENVIRONMENT_VARS['ftp_compra_port'])
#      ftp.passive = true
#      ftp.login(ENVIRONMENT_VARS['ftp_compra_username'],ENVIRONMENT_VARS['ftp_compra_password'])
#      ftp.chdir(ENVIRONMENT_VARS['ftp_compra_images_dir'])
#      arquivo = "#{RAILS_ROOT}/public/images/pacotes/#{self.pagina_de_pacote_id}/#{self.id}.jpg"
#      if File.exist?(arquivo)
#        #logger.error "\n\n\n###\nUPANDO\n###\n\n\n"
#        r = ftp.putbinaryfile(arquivo, "#{self.cc_id}.jpg", Net::FTP::DEFAULT_BLOCKSIZE)
#        #logger.error "\n\n\n#######"
#        #logger.error r
#        #logger.error "#######\n\n\n"
#      else
#        #logger.error "\n\n\n###\nUNKNOW IMAGE\n###\n\n\n"
#      end
#      ftp.close
#      #logger.error "\n\n\n###\nFTP CONNECTION CLOSED\n###\n\n\n"
#    end
  end
end