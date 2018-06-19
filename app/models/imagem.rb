class Imagem < ActiveRecord::Base
  require 'ftools'
  require 'mini_magick'
  
  validates_presence_of :legenda
  
  belongs_to :asset, :polymorphic => true
  
  validates_format_of :content_type, 
                      :with => /^image/, 
                      :message => "--- você só pode mandar imagens!" 

  after_save :move_file, :visor, :destaque, :thumb, :destaque_maior
  
  def uploaded_picture=(picture_field) 
    if (!picture_field.is_a?(String))
      self.nome = base_part_of(picture_field.original_filename) 
      self.content_type = picture_field.content_type.chomp
      
      dir = "#{RAILS_ROOT}/public/cache"
      filename = File.join(dir,self.nome)
      File.open(filename, "wb") { |f| f.write(picture_field.read) }
      #self.imagem = picture_field.read
    end
  end 

  def base_part_of(file_name) 
    File.basename(file_name).gsub(/[^\w._-]/, '') 
  end
  
  def move_file
    dir = "#{RAILS_ROOT}/public/cache"
    original_file = File.join(dir,self.nome)
    filename = File.join(dir,self.id.to_s+'.jpg')
    File.copy(original_file,filename)
  end
  
    
  
  def checkCache(id,tipo)
    case tipo
      when 'thumb'
        filename = "#{RAILS_ROOT}/public/cache/#{id}_thumb.jpg"
        #size = "80x120"
        size = "320x120" #mudar aqui
      when 'visor'
        filename = "#{RAILS_ROOT}/public/cache/#{id}_visor.jpg"
        size = "940x180"
      when 'destaque'
        filename = "#{RAILS_ROOT}/public/cache/#{id}_destaque.jpg"
        size = "160x100"
      when 'destaque_maior'
        filename = "#{RAILS_ROOT}/public/cache/#{id}_produto.jpg"
        size = "220x140"
    end
   
    
    if (!File.exists?(filename) || File.new(filename).mtime <= File.new("#{RAILS_ROOT}/public/cache/#{id}.jpg").mtime)
      image = MiniMagick::Image.from_file("#{RAILS_ROOT}/public/cache/#{id}.jpg")
      image.resize(size)
      if (tipo == 'thumb_noticia')
        if (image[:height] > 60)
          shave_off = (image[:height] - 60)
          image.chop("0x#{shave_off}")
          end
      end
      image.write(filename)
    end

    filename
  end
  
  def visor
    filename = checkCache(self.id.to_s,'visor')
  end
  
  def destaque
    filename = checkCache(self.id.to_s,'destaque')
  end
  
  def thumb
    filename = checkCache(self.id.to_s,'thumb')
  end
  
  def destaque_maior
    filename = checkCache(self.id.to_s,'destaque_maior')
  end
  
end
