class AddFixingToVideo < ActiveRecord::Migration
  def self.up
    remove_column :videos, :teatro_id
    add_column :videos, :asset_id, :integer
    add_column :videos, :asset_type, :string
  end

  def self.down
    add_column :videos, :teatro_id
    add_column :videos, :espetaculo_id
  end
end
