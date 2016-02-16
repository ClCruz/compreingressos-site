class AddOcultaCidadeTeatroGeneroToHomeModulos < ActiveRecord::Migration
  def self.up
    add_column :home_modulos, :ocultar_cidade, :boolean
    add_column :home_modulos, :ocultar_teatro, :boolean
    add_column :home_modulos, :ocultar_genero, :boolean
  end

  def self.down
    remove_column :home_modulos, :ocultar_genero
    remove_column :home_modulos, :ocultar_teatro
    remove_column :home_modulos, :ocultar_cidade
  end
end
