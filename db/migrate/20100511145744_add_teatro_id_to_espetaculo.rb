class AddTeatroIdToEspetaculo < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :teatro_id, :integer
  end

  def self.down
    remove_column :espetaculos, :teatro_id
  end
end
