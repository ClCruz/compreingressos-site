class AddEstadoToPontosdevenda < ActiveRecord::Migration
  def self.up
  	add_column :pontosdevenda, :estado_id, :integer
  	add_index :pontosdevenda, :estado_id
  end

  def self.down
  	remove_column :pontosdevenda, :estado_id
  end
end
