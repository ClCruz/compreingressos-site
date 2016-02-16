class AddCamposToEspetaculos < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :cor_da_borda_do_box, :string
    add_column :espetaculos, :cor_do_texto_do_cabecalho, :string
    add_column :espetaculos, :cor_do_link_do_cabecalho, :string
    add_column :espetaculos, :cor_da_borda_das_imagens, :string
  end

  def self.down
    remove_column :espetaculos, :cor_da_borda_do_box
    remove_column :espetaculos, :cor_do_texto_do_cabecalho
    remove_column :espetaculos, :cor_do_link_do_cabecalho
    remove_column :espetaculos, :cor_da_borda_das_imagens
  end
end
