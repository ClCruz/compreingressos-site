class AddFieldsToHomeModulo < ActiveRecord::Migration
  def self.up
    add_column :home_modulos, :link, :string
    add_column :home_modulos, :blank, :boolean
  end

  def self.down
    remove_column :home_modulos, :blank
    remove_column :home_modulos, :link
  end
end
