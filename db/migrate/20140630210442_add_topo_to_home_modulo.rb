class AddTopoToHomeModulo < ActiveRecord::Migration
  def self.up
    add_column :home_modulos, :topo, :boolean
  end

  def self.down
    remove_column :home_modulos, :topo
  end
end
