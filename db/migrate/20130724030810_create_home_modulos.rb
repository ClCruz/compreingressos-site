class CreateHomeModulos < ActiveRecord::Migration
  def self.up
    create_table :home_modulos do |t|
      t.string :titulo
      t.datetime :entrada
      t.datetime :saida
      t.integer :orderm

      t.timestamps
    end
  end

  def self.down
    drop_table :home_modulos
  end
end
