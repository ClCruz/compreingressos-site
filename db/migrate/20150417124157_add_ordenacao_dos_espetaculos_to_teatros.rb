class AddOrdenacaoDosEspetaculosToTeatros < ActiveRecord::Migration
  def self.up
    add_column :teatros, :ordenacao_dos_espetaculos, :integer, :default => 1
  end

  def self.down
    remove_column :teatros, :ordenacao_dos_espetaculos
  end
end