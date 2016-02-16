class AddGeneroIdToEspetaculo < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :genero_id, :integer
  end

  def self.down
    remove_column :espetaculos, :genero_id
  end
end
