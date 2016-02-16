class AddCorDoHeaderToPaginaDePacote < ActiveRecord::Migration
  def self.up
    add_column :pagina_de_pacotes, :cor_do_header, :string
  end

  def self.down
    remove_column :pagina_de_pacotes, :cor_do_header
  end
end
