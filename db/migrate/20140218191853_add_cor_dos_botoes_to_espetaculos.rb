class AddCorDosBotoesToEspetaculos < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :cor_dos_botoes, :integer
  end

  def self.down
    remove_column :espetaculos, :cor_dos_botoes
  end
end
