class AddLateraisToHomeBackground < ActiveRecord::Migration
  def self.up
    add_column :home_backgrounds, :esquerda_blank, :boolean
    add_column :home_backgrounds, :esquerda_link, :string
    add_column :home_backgrounds, :direita_blank, :boolean
    add_column :home_backgrounds, :direita_link, :string
  end

  def self.down
    remove_column :home_backgrounds, :direita_link
    remove_column :home_backgrounds, :direita_blank
    remove_column :home_backgrounds, :esquerda_link
    remove_column :home_backgrounds, :esquerda_blank
  end
end
