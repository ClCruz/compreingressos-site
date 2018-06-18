class AddCoresDoBoxEspetaculoEspecialToEspetaculos < ActiveRecord::Migration
  def self.up
    remove_column :espetaculos, :estilo_de_cores
    add_column :espetaculos, :cor_de_fundo_do_box, :string
    add_column :espetaculos, :cor_do_texto_do_box, :string
    add_column :espetaculos, :cor_do_link_do_box, :string
  end

  def self.down
    add_column :espetaculos, :estilo_de_cores, :integer
    remove_column :espetaculos, :cor_do_link_do_box
    remove_column :espetaculos, :cor_do_texto_do_box
    remove_column :espetaculos, :cor_de_fundo_do_box
  end
end
