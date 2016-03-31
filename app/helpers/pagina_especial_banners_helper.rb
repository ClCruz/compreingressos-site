module PaginaEspecialBannersHelper
	def remove_link_unless_new_record_cv(fields)
		unless fields.object.new_record?
		  out = ''
		  out << fields.hidden_field(:_destroy)
		  out << link_to_function('Remover', "$(this).prev().attr('value',1);$(this).parent('.#{fields.object.class.name.underscore}').slideUp(500);", :class => "botao")
		  out.html_safe
		else
		  out = ''
		  out << link_to_function('Remover', "$(this).parent('.#{fields.object.class.name.underscore}').slideUp(500,function(){ $(this).remove(); });", :class => "botao")
		  out.html_safe
		end
	end

	def add_entrada_link_cv(form)
		entrada = render(:partial => 'layouts/produtos_entrada', :locals => { :f => form, :produtos_entrada => ProdutosEntrada.new })
		link = %{
		  var new_produtos_entrada_id = new Date().getTime();
		  $('.produtos_entradas').append("#{ escape_javascript entrada }".replace(/index_to_replace/g, new_produtos_entrada_id))
		  var id = $('textarea').last().attr('id');
		  tinyMCE.settings = tinymceConfigs[0];
		  tinyMCE.execCommand('mceAddControl', true, id);
		  $('.produtos_entrada').last().slideDown(500);
		}
		link_to_function image_tag('/admin/botao_adicionar.png')+'Adicionar entrada', link, :class => "botao"# do |page|
	end
end
