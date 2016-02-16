class AddMapsToTeatro < ActiveRecord::Migration
  def self.up
    add_column :teatros, :maps, :string
  end

  def self.down
    remove_column :teatros, :maps
  end
end
