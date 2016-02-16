class AddSetoresToPacotes < ActiveRecord::Migration
  def self.up
    add_column :pacotes, :setores, :text
  end

  def self.down
    remove_column :pacotes, :setores
  end
end
