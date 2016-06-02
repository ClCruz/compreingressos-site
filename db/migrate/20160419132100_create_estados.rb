class CreateEstados < ActiveRecord::Migration
  def self.up
    create_table :estados do |t|
      t.integer :id
      t.string :nome
      t.string :sigla
      t.integer :regiao_geografica_id
      t.integer :pais_id

      t.timestamps
    end
  end

  def self.down
    drop_table :estados
  end
end
