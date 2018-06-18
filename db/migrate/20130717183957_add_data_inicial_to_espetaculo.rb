class AddDataInicialToEspetaculo < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :data_inicial, :date
  end

  def self.down
    remove_column :espetaculos, :data_inicial
  end
end
