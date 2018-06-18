class CreatePublicidades < ActiveRecord::Migration
  def self.up
    create_table :publicidades do |t|
      t.string :nome
      t.integer :tempo_de_exibicao
      t.string :link
      t.text :script
      t.boolean :blank
      t.integer :ordem
      t.string :imagem_file_name
      t.string :imagem_content_type
      t.integer :imagem_file_size
      t.datetime :imagem_updated_at
      t.boolean :status
      t.date :data_inicio
      t.date :data_fim

      t.timestamps
    end
  end

  def self.down   
    drop_table :publicidades
  end
end
