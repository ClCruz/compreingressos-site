class AddDescontoToEspetaculo < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :desconto, :text
  end

  def self.down
    remove_column :espetaculos, :desconto
  end
end
