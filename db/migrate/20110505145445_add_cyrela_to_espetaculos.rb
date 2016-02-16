class AddCyrelaToEspetaculos < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :cyrela, :boolean
  end

  def self.down
    remove_column :espetaculos, :cyrela
  end
end