class AddCorDeFundoToPaginaDePacotes < ActiveRecord::Migration
  def self.up
    add_column :pagina_de_pacotes, :cor_de_fundo, :string
  end

  def self.down
    remove_column :pagina_de_pacotes, :cor_de_fundo
  end
end
