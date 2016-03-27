class CidadesConjuntoCidades < ActiveRecord::Migration
  def self.up
    create_table :cidades_conjunto_cidades, :id => false do |t|
      t.integer :conjunto_cidade_id
      t.integer :cidade_id
    end
    add_index :cidades_conjunto_cidades, [:conjunto_cidade_id, :cidade_id], :unique => true
  end

  def self.down
    drop_table :cidades_conjunto_cidades
  end
end
