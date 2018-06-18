
xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", "xmlns:g" => "http://base.google.com/ns/1.0" do
	xml.channel do
		xml.title "Compre Ingressos"
		xml.link "https://compreingressos.com"
		xml.description "Lorem ipsum dolor sit amet"

		@espetaculos.each do |esp|
			xml.item do
				xml.tag! "g:id", esp.cc_id
				xml.tag! "g:title", esp.nome
				xml.tag! ("g:description") { xml.cdata! esp.sinopse }
				xml.tag! "g:google_product_category", "499969" # Artes e entretenimento > Ingressos de eventos
				xml.tag! "g:link", espetaculo_url(esp)
				xml.tag! "g:image_link", "https://compreingressos.com#{esp.fundo.url}" if esp.fundo?
				xml.tag! "g:price", "%5.2f" % esp.g_price.round(2) unless esp.g_price.nil?
				xml.tag! "g:sale_price", "%5.2f" % esp.g_sale_price.round(2) unless esp.g_sale_price.nil?
				xml.tag! "g:brand", "Compre Ingressos"
				xml.tag! "g:adult", "FALSE"
				xml.tag! ("g:product_type") { xml.cdata! "Artes e entretenimento > Ingressos de eventos" }
				xml.tag! "g:mobile_link", espetaculo_url(esp)
				xml.tag! ("g:filters") { xml.cdata! "cidade=#{!esp.cidade.nil? ? esp.cidade.nome: ''}, teatro=#{!esp.teatro.nil? ? esp.teatro.nome: ''}, gênero=#{!esp.genero.nil? ? esp.genero.nome: ''}" }
			end
		end
	end 
end