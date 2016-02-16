class ImagemsController < ApplicationController
  before_filter :authorize
  newrelic_ignore_apdex
  
  require 'mini_magick'
  
  def checkCache(id,tipo)
    case tipo
      when 'thumb'
        filename = "#{RAILS_ROOT}/public/cache/#{id}_thumb.jpg"
        size = "80x120"
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
    filename = checkCache(params[:id],'visor')
    send_file(filename, {:disposition => 'inline', :type => 'image/jpeg'})
  end
  
  def destaque
    filename = checkCache(params[:id],'destaque')
    response.headers["Pragma"] = "cache"
    response.headers["Cache-Control"] = "public"
    send_file(filename, {:disposition => 'inline', :type => 'image/jpeg'})
  end
  
  def thumb
    filename = checkCache(params[:id],'thumb')
    send_file(filename, {:disposition => 'inline', :type => 'image/jpeg'})
  end
  
  def show
    filename = "#{RAILS_ROOT}/public/cache/#{params[:id]}.jpg"
    send_file(filename, {:disposition => 'inline', :type => 'image/jpeg'})
  end
  
  def destaque_maior
    filename = checkCache(params[:id],'destaque_maior')
    send_file(filename, {:disposition => 'inline', :type => 'image/jpeg'})
  end
end
