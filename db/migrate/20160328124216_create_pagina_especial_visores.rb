class CreatePaginaEspecialVisores < ActiveRecord::Migration
  def self.up
    create_table :pagina_especial_visores do |t|
      t.references :pagina_especial
      t.string :link
      t.boolean :blank
      t.integer :ordem
      t.string :imagem_file_name
      t.string :imagem_content_type
      t.integer :imagem_file_size
      t.datetime :imagem_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :pagina_especial_visores
  end
end
