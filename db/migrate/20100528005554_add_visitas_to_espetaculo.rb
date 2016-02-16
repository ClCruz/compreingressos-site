class AddVisitasToEspetaculo < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :visitas, :integer, :default => 0
  end

  def self.down
    remove_column :espetaculos, :visitas
  end
end
