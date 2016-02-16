class CreateEventosRealizados < ActiveRecord::Migration
  def self.up
    create_table :cidades do |t|
      t.string :temporada
      t.string :ordem
      t.integer :espetaculo_id

      t.timestamps
    end
  end

  def self.down
    drop_table :temporada
    drop_table :ordem
    drop_table :espetaculo_id
  end
end