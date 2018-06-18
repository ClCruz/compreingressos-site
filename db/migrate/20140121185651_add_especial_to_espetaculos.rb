class AddEspecialToEspetaculos < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :especial, :boolean
  end

  def self.down
    remove_column :espetaculos, :especial
  end
end
