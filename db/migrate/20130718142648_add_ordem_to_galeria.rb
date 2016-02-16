class AddOrdemToGaleria < ActiveRecord::Migration
  def self.up
    add_column :galerias, :ordem, :integer
  end

  def self.down
    remove_column :galerias, :ordem
  end
end
