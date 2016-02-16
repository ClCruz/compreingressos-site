class AddDescricaoToVisores < ActiveRecord::Migration
  def self.up
    add_column :visores, :descricao, :string
  end

  def self.down
    remove_column :visores, :descricao
  end
end
