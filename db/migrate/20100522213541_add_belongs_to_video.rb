class AddBelongsToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :espetaculo_id, :integer
    add_column :videos, :teatro_id, :integer
  end

  def self.down
    remove_column :videos, :teatro_id
    remove_column :videos, :espetaculo_id
  end
end
