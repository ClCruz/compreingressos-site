class CreateMunicipios < ActiveRecord::Migration
  def self.up
    create_table :municipios do |t|
      t.integer :id
      t.string :nome
      t.integer :estado_id
      t.integer :pais_id
      t.integer :nr_habitantes

      t.timestamps
    end
  end

  def self.down
    drop_table :municipios
  end
end
