class CreateConjuntoCidades < ActiveRecord::Migration
  def self.up
    create_table :conjunto_cidades do |t|
      t.string :nome
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :conjunto_cidades
  end
end
