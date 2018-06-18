class AddCcIdToPacotes < ActiveRecord::Migration
  def self.up
    add_column :pacotes, :cc_id, :integer
  end

  def self.down
    remove_column :pacotes, :cc_id
  end
end
