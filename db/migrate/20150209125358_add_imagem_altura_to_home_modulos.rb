class AddImagemAlturaToHomeModulos < ActiveRecord::Migration
  def self.up
    add_column :home_modulos, :imagem_altura, :integer
  end

  def self.down
    remove_column :home_modulos, :imagem_altura
  end
end
