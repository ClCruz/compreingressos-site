class ChangeEspetaculosDescriptionSize < ActiveRecord::Migration
  def self.up
    change_column :espetaculos, :description, :string, :limit => 2000
  end

  def self.down
    change_column :espetaculos, :description, :string, :limit => 255
  end
end
