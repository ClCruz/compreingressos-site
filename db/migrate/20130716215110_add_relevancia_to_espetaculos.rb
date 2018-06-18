class AddRelevanciaToEspetaculos < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :relevancia, :integer
  end

  def self.down
    remove_column :espetaculos, :relevancia
  end
end
