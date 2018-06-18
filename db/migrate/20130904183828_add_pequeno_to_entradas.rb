class AddPequenoToEntradas < ActiveRecord::Migration
  def self.up
    add_column :entradas, :pequeno, :boolean
  end

  def self.down
    remove_column :entradas, :pequeno
  end
end
