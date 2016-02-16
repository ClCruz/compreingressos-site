class AddParallaxToCidades < ActiveRecord::Migration
  def self.up
    add_column :cidades, :parallax, :boolean
    add_column :cidades, :parallax_valor, :string
  end

  def self.down
    remove_column :cidades, :parallax_valor
    remove_column :cidades, :parallax
  end
end
