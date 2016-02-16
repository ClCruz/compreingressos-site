class AddDataMaximaToEspetaculos < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :data_maxima, :date
  end

  def self.down
    remove_column :espetaculos, :data_maxima
  end
end
