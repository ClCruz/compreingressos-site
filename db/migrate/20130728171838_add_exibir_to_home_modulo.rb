class AddExibirToHomeModulo < ActiveRecord::Migration
  def self.up
    add_column :home_modulos, :exibir, :integer
  end

  def self.down
    remove_column :home_modulos, :exibir
  end
end
