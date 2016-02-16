class AddBairroToTeatro < ActiveRecord::Migration
  def self.up
    add_column :teatros, :bairro, :string
  end

  def self.down
    remove_column :teatros, :bairro
  end
end
