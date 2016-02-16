class AddFieldsToCidades < ActiveRecord::Migration
  def self.up
    add_column :cidades, :cor_de_fundo, :string
    add_column :cidades, :altura_de_inicio, :integer
    add_column :cidades, :mapeamento_de_imagem, :text
  end

  def self.down
    remove_column :cidades, :mapeamento_de_imagem
    remove_column :cidades, :altura_de_inicio
    remove_column :cidades, :cor_de_fundo
  end
end
