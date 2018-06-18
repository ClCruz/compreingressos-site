class RemoveFieldsToPontosdevenda < ActiveRecord::Migration
  def self.up
  	remove_column :pontosdevenda, :titulo
  	remove_column :pontosdevenda, :texto
  end

  def self.down
  	add_column :pontosdevenda, :titulo
  	add_column :pontosdevenda, :texto
  end
end
