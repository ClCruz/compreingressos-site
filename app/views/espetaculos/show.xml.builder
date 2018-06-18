xml.instruct! :xml, :version => '1.0', :encoding => 'UTF-8'
xml.Offer do
  xml.Id @espetaculo.id
  xml.Code @espetaculo.cc_id
  xml.Title @espetaculo.nome
  xml.SiteDetailURL "http://www.compreingressos.com#{espetaculo_path(@espetaculo)}"
  xml.Description @espetaculo.description
  xml.Sinopse @espetaculo.sinopse
  xml.Price @espetaculo.preco
  xml.Season ""
  xml.Time @espetaculo.horario
  xml.Rating @espetaculo.classificacao.texto
  xml.Images do
    xml.Thumb "http://www.compreingressos.com/#{@espetaculo.img_miniatura.url(:miniatura)}"
    xml.HighLight @espetaculo.img_principal? ? "http://www.compreingressos.com/#{@espetaculo.img_principal.url}" : ""
  end
  xml.Category do
    xml.Id @espetaculo.genero.id
    xml.Name @espetaculo.genero.nome
  end
  xml.Place do
    xml.Id @espetaculo.teatro.id
    xml.Address @espetaculo.teatro.endereco
    xml.AddressDistrict @espetaculo.teatro.bairro
    xml.AddressCityId @espetaculo.teatro.cidade.id 
    xml.AddressCity @espetaculo.teatro.cidade.nome
    xml.AddressState @espetaculo.teatro.cidade.estado
    xml.AddressPhone @espetaculo.teatro.telefone
    xml.GoogleMaps @espetaculo.teatro.maps
  end
  xml.Details do
    @espetaculo.entradas.each do |entrada|
      xml.Detail do
        xml.Key entrada.atributo
        xml.Value entrada.valor
      end
    end
  end
  xml.Photos do
    i=1
    while i < @espetaculo.galerias.size
      xml.Photo do
        xml.Image "http://www.compreingressos.com/#{@espetaculo.galerias[i].imagem.url(:big)}"
        xml.Thumb "http://www.compreingressos.com/#{@espetaculo.galerias[i].imagem.url(:thumb)}"
        xml.Title @espetaculo.galerias[i].respond_to?('title') ? @espetaculo.galerias[i].title : ""
      end
      i+=1
    end
  end
end