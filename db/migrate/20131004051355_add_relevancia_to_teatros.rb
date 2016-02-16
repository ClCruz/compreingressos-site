class AddRelevanciaToTeatros < ActiveRecord::Migration
  def self.up
    add_column :teatros, :relevancia, :integer
  end

  def self.down
    remove_column :teatros, :relevancia
  end
end
