class AddFieldsToVisor < ActiveRecord::Migration
  def self.up
  	add_column :visores, :posicao, :string
  end

  def self.down
  	remove_column :visores, :posicao
  end
end
