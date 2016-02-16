class RemoveTeatroIdFromPacotes < ActiveRecord::Migration
  def self.up
    remove_column :pacotes, :teatro_id
  end

  def self.down
    add_column :pacotes, :teatro_id
  end
end
