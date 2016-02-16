class AddCoresDoBoxEspetaculoEspecialToPaginaEspecial < ActiveRecord::Migration
  def self.up
    remove_column :pagina_especiais, :estilo
    add_column :pagina_especiais, :cor_de_fundo_do_box, :string
    add_column :pagina_especiais, :cor_do_texto_do_box, :string
    add_column :pagina_especiais, :cor_do_link_do_box, :string
    add_column :pagina_especiais, :cor_da_borda_do_espetaculo, :string
  end

  def self.down
    add_column :pagina_especiais, :estilo, :integer
    remove_column :pagina_especiais, :cor_do_link_do_box
    remove_column :pagina_especiais, :cor_do_texto_do_box
    remove_column :pagina_especiais, :cor_de_fundo_do_box
    remove_column :pagina_especiais, :cor_da_borda_do_espetaculo
  end
end
