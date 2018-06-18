class CreatePaginaEspecialFiltros < ActiveRecord::Migration
  def self.up
    create_table :pagina_especial_filtros do |t|
      t.string :nome
      t.string :url

      t.timestamps
    end
    add_index :pagina_especial_filtros, :nome, :unique => true
    add_index :pagina_especial_filtros, :url, :unique => true
  end

  def self.down
    drop_table :pagina_especial_filtros
  end
end
