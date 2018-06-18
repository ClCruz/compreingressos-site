class AddAlturaMobileToPaginaEspecial < ActiveRecord::Migration
  def self.up
    add_column :pagina_especiais, :altura_de_inicio_da_listagem_mobile, :integer, :default => 0
  end

  def self.down
    remove_column :pagina_especiais, :altura_de_inicio_da_listagem_mobile
  end
end
