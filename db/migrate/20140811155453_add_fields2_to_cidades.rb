class AddFields2ToCidades < ActiveRecord::Migration
  def self.up
    add_column :cidades, :cor_de_fundo_do_box, :string
    add_column :cidades, :cor_de_texto_do_box, :string
    add_column :cidades, :cor_de_link_do_box, :string
    add_column :cidades, :cor_da_borda_do_espetaculo, :string
    add_column :cidades, :cor_do_header, :string
    add_column :cidades, :cor_da_borda_do_header, :string
  end

  def self.down
    remove_column :cidades, :cor_da_borda_do_header
    remove_column :cidades, :cor_do_header
    remove_column :cidades, :cor_da_borda_do_espetaculo
    remove_column :cidades, :cor_de_link_do_box
    remove_column :cidades, :cor_de_texto_do_box
    remove_column :cidades, :cor_de_fundo_do_box
  end
end