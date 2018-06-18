class ChangeValorEntradas < ActiveRecord::Migration
  def self.up
    change_column :entradas, :valor, :text
  end

  def self.down
    change_column :entradas, :valor, :string
  end
end
