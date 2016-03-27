class AddFieldsToConjuntoCidades < ActiveRecord::Migration
  def self.up
  	add_column :conjunto_cidades, :cor_de_fundo, :string
    add_column :conjunto_cidades, :imagem_de_fundo_file_name, :string
    add_column :conjunto_cidades, :imagem_de_fundo_content_type, :string
    add_column :conjunto_cidades, :cor_de_fundo_do_box, :string 
    add_column :conjunto_cidades, :cor_de_texto_do_box, :string 
    add_column :conjunto_cidades, :cor_de_link_do_box, :string 
    add_column :conjunto_cidades, :cor_da_borda_do_espetaculo, :string 
    add_column :conjunto_cidades, :cor_do_header, :string 
    add_column :conjunto_cidades, :cor_da_borda_do_header, :string 
    add_column :conjunto_cidades, :parallax_valor, :string
  	add_column :conjunto_cidades, :imagem_de_fundo_file_size, :integer
    add_column :conjunto_cidades, :altura_de_inicio, :integer
  	add_column :conjunto_cidades, :parallax, :boolean
  	add_column :conjunto_cidades, :mapeamento_de_imagem, :text
  	add_column :conjunto_cidades, :imagem_de_fundo_updated_at, :datetime
  end

  def self.down
  	remove_column :conjunto_cidades, :cor_de_fundo
    remove_column :conjunto_cidades, :imagem_de_fundo_file_name
    remove_column :conjunto_cidades, :imagem_de_fundo_content_type
    remove_column :conjunto_cidades, :cor_de_fundo_do_box
    remove_column :conjunto_cidades, :cor_de_texto_do_box
    remove_column :conjunto_cidades, :cor_de_link_do_box
    remove_column :conjunto_cidades, :cor_da_borda_do_espetaculo
    remove_column :conjunto_cidades, :cor_do_header
    remove_column :conjunto_cidades, :cor_da_borda_do_header
    remove_column :conjunto_cidades, :parallax_valor
    remove_column :conjunto_cidades, :imagem_de_fundo_file_size
    remove_column :conjunto_cidades, :altura_de_inicio
    remove_column :conjunto_cidades, :parallax
    remove_column :conjunto_cidades, :mapeamento_de_imagem
    remove_column :conjunto_cidades, :imagem_de_fundo_updated_at
  end
end
