class AddCcEventoIdToPacotes < ActiveRecord::Migration
  def self.up
    add_column :pacotes, :cc_evento_id, :integer
  end

  def self.down
    remove_column :pacotes, :cc_evento_id
  end
end
