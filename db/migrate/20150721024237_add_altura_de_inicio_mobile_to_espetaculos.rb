class AddAlturaDeInicioMobileToEspetaculos < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :altura_de_inicio_mobile, :integer
  end

  def self.down
    remove_column :espetaculos, :altura_de_inicio_mobile
  end
end
