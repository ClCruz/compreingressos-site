class RemoveCidadeFromPontosdevenda < ActiveRecord::Migration
  def self.up
  	remove_column :pontosdevenda, :cidade_id
  end

  def self.down
  	add_column :pontosdevenda, :cidade_id
  end
end
