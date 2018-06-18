class AddCorDoHeaderToPaginaEspeciais < ActiveRecord::Migration
  def self.up
    add_column :pagina_especiais, :cor_do_header, :string, :default => ""
  end

  def self.down
    remove_column :pagina_especiais, :cor_do_header
  end
end
