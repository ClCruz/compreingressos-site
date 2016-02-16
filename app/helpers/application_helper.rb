# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def add_imagem_link(name, form)
    link_to_function name do |page|
      imagem = render(:partial => 'layouts/imagem', :locals => { :pf => form, :imagem => Galeria.new })
      page << %{
        var new_imagem_id = new Date().getTime();
        $('imagems').insert({ bottom: "#{ escape_javascript imagem }".replace(/index_to_replace/g, new_imagem_id) });
      }
    end
  end
  
  def add_teatro_imagem_link(name, form)
    link_to_function name do |page|
      imagem = render(:partial => 'layouts/teatro_imagem', :locals => { :pf => form, :imagem => TeatroImagen.new })
      page << %{
        var new_imagem_id = new Date().getTime();
        $('imagems').insert({ bottom: "#{ escape_javascript imagem }".replace(/index_to_replace/g, new_imagem_id) });
      }
    end
  end
  
  def add_video_link(name, form)
    link_to_function name do |page|
      video = render(:partial => 'layouts/video', :locals => { :pf => form, :video => Video.new })
      page << %{
        var new_video_id = new Date().getTime();
        $('videos').insert({ bottom: "#{ escape_javascript video }".replace(/index_to_replace/g, new_video_id) });
      }
    end
  end
  
  def add_entrada_link(name,form)
    link_to_function name do |page|
      entrada = render(:partial => 'layouts/entrada', :locals => { :pf => form, :entrada => Entrada.new })
#      page << %{
#        var new_entrada_id = new Date().getTime();
#        $('entradas').insert({ bottom: "#{ escape_javascript entrada }".replace(/index_to_replace/g, new_entrada_id) });
#        var new_editor = new tinymce.Editor('entrada_'+new_entrada_id, {});
#        new_editor.render();
#      }
      page << %{
        var new_entrada_id = new Date().getTime();
        $('entradas').insert({ bottom: "#{ escape_javascript entrada }".replace(/index_to_replace/g, new_entrada_id) });
      }
    end
  end
  
  def add_cidade_visores(name,form)
    link_to_function name do |page|
      cv = render(:partial => 'layouts/cidade_visores', :locals => { :pf => form, :cidade_visores => CidadeVisor.new })
      page << %{
        var new_entrada_id = new Date().getTime();
        $('cidade_visores').insert({ bottom: "#{ escape_javascript cv }".replace(/index_to_replace/g, new_entrada_id) });
      }
    end
  end
  
  def add_pacote_espetaculo_link(name,form,espetaculos)
    link_to_function name do |page|
      pe = render(:partial => 'layouts/pacotes_espetaculos', :locals => { :pf => form, :pacotes_espetaculo => PacotesEspetaculo.new, :espetaculos => espetaculos})
      page << %{
        var new_pe_id = new Date().getTime();
        $('pacotes_espetaculos').insert({ bottom: "#{ escape_javascript pe }".replace(/index_to_replace/g, new_pe_id) });
      }
    end
  end
  
#  def add_pacote_espetaculo_link(name, form)
#    link_to_function name do |page|
#      pe = render(:partial => 'layouts/pacotes_espetaculos', :locals => { :pf => form, :pacotes_espetaculo => PacotesEspetaculo.new })
#      page << %{
#        jQuery('#pacotes_espetaculos').append("#{ pe }");
#      }
#    end
#  end
  
  def add_espetaculo_home(name,form)
    link_to_function name do |page|
      espetaculo = render(:partial => 'layouts/espetaculo_home', :locals => {:pf => form})
      page << %{
        jQuery('#espetaculos_home').append("#{ escape_javascript espetaculo }");jQuery('#espetaculos_home select').last().focus();
      }
    end
  end
  
  def add_espetaculo_link(name,form,espetaculos_options)
    link_to_function name do |page|
      espetaculo = render(:partial => 'layouts/espetaculo_link', :locals => {:form => form, :espetaculos_options => espetaculos_options})
      page << %{
        jQuery('#espetaculos').append("#{ escape_javascript espetaculo }");jQuery('#espetaculos select').last().focus();
      }
    end
  end
  
  def add_setor_cadastro(name)
    link_to_function name do |page|
      setor = render(:partial => 'layouts/setor')
      page << %{
        $('setores').insert({ bottom: "#{ escape_javascript setor }"});
      }
    end
  end
  
  def remove_link_unless_new_record(fields)
    unless fields.object.new_record?
      out = ''
      out << fields.hidden_field(:_destroy)
      out << link_to_function("Remover o item acima", "jQuery(this).prev().attr('value',1);jQuery(this).parent().parent('.#{fields.object.class.name.underscore}').slideUp(500);jQuery(this).parent().parent('.#{fields.object.class.name.underscore}').next('hr').hide();")
      out
    else
      out = ''
      out << link_to_function("Remover o item acima", "jQuery(this).parent('.#{fields.object.class.name.underscore}').slideUp(500,function(){ jQuery(this).remove(); });")
      out
    end
  end
  
  def nl2br(s)
    if !s.blank?
      s.gsub("\n","<br />")
    else
      s
    end
  end
  
  def data_br(t = Time.now)
    case t.strftime("%a")
      when "Sun"
        data = "Domingo, "
      when "Mon"
        data = "Segunda, "
      when "Tue"
        data = "Terça, "
      when "Wed"
        data = "Quarta, "
      when "Thu"
        data = "Quinta, "
      when "Fri"
        data = "Sexta, "
      when "Sat"
        data = "Sábado, "
    end
    data += t.strftime("%d de ")
    
    case t.strftime("%m")
      when "01"
        data += "janeiro de "
      when "02"
        data += "fevereiro de "
      when "03"
        data += "março de "
      when "04"
        data += "abril de "
      when "05"
        data += "maio de "
      when "06"
        data += "junho de "
      when "07"
        data += "julho de "
      when "08"
        data += "agosto de "
      when "09"
        data += "setembro de "
      when "10"
        data += "outubro de "
      when "11"
        data += "novembro de "
      when "12"
        data += "dezembro de "
    end
    data += t.strftime("%Y")
  end
  
  def pagina_selecionada?(obj, pagina)
    if obj
       obj.pagina_especiais.include?(pagina)
    else
      false
    end
  end
  
  def espetaculo_selecionado?(obj, espetaculo)
    if obj
       obj.espetaculos.include?(espetaculo)
    else
      false
    end
  end

  def filtro_selecionado?(obj, espetaculo)
    if obj
      obj.pagina_especial_filtros.include?(espetaculo)
    else
      false
    end
  end

  def filtro_pacote_selecionado?(obj, pacote)
    if obj
      obj.pacote_filtros.include?(pacote)
    else
      false
    end
  end
  
  def lparam(s)
    re = s.gsub(/[^0-9A-Za-z\sáàéíóúãïüõç]/, '')
    re
  end
end
