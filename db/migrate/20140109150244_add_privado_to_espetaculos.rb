class AddPrivadoToEspetaculos < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :privado, :boolean
  end

  def self.down
    remove_column :espetaculos, :privado
  end
end
