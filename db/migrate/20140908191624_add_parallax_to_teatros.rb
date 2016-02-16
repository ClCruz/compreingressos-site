class AddParallaxToTeatros < ActiveRecord::Migration
  def self.up
    add_column :teatros, :parallax, :boolean
    add_column :teatros, :parallax_valor, :string
  end

  def self.down
    remove_column :teatros, :parallax_valor
    remove_column :teatros, :parallax
  end
end
