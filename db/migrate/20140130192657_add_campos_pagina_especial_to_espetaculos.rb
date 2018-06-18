class AddCamposPaginaEspecialToEspetaculos < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :cor_de_fundo, :string
    add_column :espetaculos, :altura_de_inicio, :integer
    add_column :espetaculos, :estilo_de_cores, :integer
  end

  def self.down
    remove_column :espetaculos, :estilo_de_cores
    remove_column :espetaculos, :altura_de_inicio
    remove_column :espetaculos, :cor_de_fundo
  end
end
