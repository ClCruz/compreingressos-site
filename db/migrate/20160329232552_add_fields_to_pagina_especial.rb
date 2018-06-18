class AddFieldsToPaginaEspecial < ActiveRecord::Migration
  def self.up
    add_column :pagina_especiais, :texto_de_link_do_regulamento, :string
  	add_column :pagina_especiais, :link_do_regulamento, :string
  	add_column :pagina_especiais, :cor_de_link_do_regulamento, :string
  	add_column :pagina_especiais, :blank_de_link_do_regulamento, :boolean
  end

  def self.down
  	remove_column :pagina_especiais, :texto_de_link_do_regulamento
    remove_column :pagina_especiais, :link_do_regulamento
  	remove_column :pagina_especiais, :cor_de_link_do_regulamento
  	remove_column :pagina_especiais, :blank_de_link_do_regulamento
  end
end
