class AddGrupoToVisor < ActiveRecord::Migration
  def self.up
  	add_column :visores, :grupo, :string
  end

  def self.down
  	remove_column :visores, :grupo
  end
end
