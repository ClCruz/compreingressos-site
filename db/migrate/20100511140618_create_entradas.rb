class CreateEntradas < ActiveRecord::Migration
  def self.up
    create_table :entradas do |t|
      t.string :atributo
      t.string :valor
      t.integer :asset_id
      t.string :asset_type

      t.timestamps
    end
  end

  def self.down
    drop_table :entradas
  end
end
