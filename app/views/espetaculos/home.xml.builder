xml.instruct! :xml, :version => '1.0', :encoding => 'UTF-8'
xml.Offers do
  @espetaculos_home.each do |espetaculo|
    if !espetaculo.cc_id.blank?
      xml.Offer do
        xml.Id espetaculo.id
        xml.Code espetaculo.cc_id
        xml.Title espetaculo.nome
        xml.SiteDetailURL "http://www.compreingressos.com#{espetaculo_path(espetaculo)}"
        xml.Images do
          xml.Thumb "http://www.compreingressos.com/cache/#{espetaculo.imagems[1].id}_produto.jpg"
          xml.HighLight "http://www.compreingressos.com/cache/#{espetaculo.imagems[1].id}.jpg"
        end
        xml.Category do
          xml.Id espetaculo.genero.id
          xml.Name espetaculo.genero.nome
        end
        xml.Place do
          xml.Id espetaculo.teatro.id
          xml.Address espetaculo.teatro.endereco
          xml.AddressDistrict espetaculo.teatro.bairro
          xml.AddressCityId espetaculo.teatro.cidade.id 
          xml.AddressCity espetaculo.teatro.cidade.nome
          xml.AddressState espetaculo.teatro.cidade.estado
          xml.AddressPhone espetaculo.teatro.telefone
          xml.GoogleMaps espetaculo.teatro.maps
        end
      end
    end
  end
end