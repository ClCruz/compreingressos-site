class AddCorDaBordaDoHeaderToPaginaEspecial < ActiveRecord::Migration
  def self.up
    add_column :pagina_especiais, :cor_da_borda_do_header, :string
  end

  def self.down
    remove_column :pagina_especiais, :cor_da_borda_do_header
  end
end
