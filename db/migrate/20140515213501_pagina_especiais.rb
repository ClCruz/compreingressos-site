class PaginaEspeciais < ActiveRecord::Migration
  def self.up
    add_column :pagina_especiais, :organizado_por, :integer, :default => 1
    add_column :pagina_especiais, :tipo_de_botao, :integer, :default => 1
    add_column :pagina_especiais, :mapeamento_de_imagem, :text, :default => ""
    add_column :pagina_especiais, :filtro_cidade, :boolean, :default => false
    add_column :pagina_especiais, :filtro_genero, :boolean, :default => false
    add_column :pagina_especiais, :busca, :boolean, :default => false
  end

  def self.down
    remove_column :pagina_especiais, :organizado_por
    remove_column :pagina_especiais, :tipo_de_botao
    remove_column :pagina_especiais, :mapeamento_de_imagem
    remove_column :pagina_especiais, :filtro_cidade
    remove_column :pagina_especiais, :filtro_genero
    remove_column :pagina_especiais, :busca
  end
end
