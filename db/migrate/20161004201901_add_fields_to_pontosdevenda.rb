class AddFieldsToPontosdevenda < ActiveRecord::Migration
  def self.up
  	add_column :pontosdevenda, :local, :string
  	add_column :pontosdevenda, :endereco, :string
  	add_column :pontosdevenda, :funcionamento, :string
  	add_column :pontosdevenda, :forma_de_pagamento, :string
  end

  def self.down
  	remove_column :pontosdevenda, :local
  	remove_column :pontosdevenda, :endereco
  	remove_column :pontosdevenda, :funcionamento
  	remove_column :pontosdevenda, :forma_de_pagamento
  end
end
