class AddTipoToHomeModulos < ActiveRecord::Migration
  def self.up
    add_column :home_modulos, :tipo, :integer
  end

  def self.down
    remove_column :home_modulos, :tipo
  end
end
