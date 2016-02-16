class RemoveMapsFromTeatros < ActiveRecord::Migration
  def self.up
    remove_column :teatros, :maps
  end

  def self.down
    add_column :teatros, :maps, :string
  end
end
