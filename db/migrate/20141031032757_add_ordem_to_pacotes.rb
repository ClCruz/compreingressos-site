class AddOrdemToPacotes < ActiveRecord::Migration
  def self.up
    add_column :pacotes, :ordem, :integer
  end

  def self.down
    remove_column :pacotes, :ordem
  end
end
