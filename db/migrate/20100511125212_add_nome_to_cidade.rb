class AddNomeToCidade < ActiveRecord::Migration
  def self.up
    add_column :cidades, :nome, :string
  end

  def self.down
    remove_column :cidades, :nome
  end
end
