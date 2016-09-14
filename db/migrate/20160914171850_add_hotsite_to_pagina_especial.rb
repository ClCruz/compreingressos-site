class AddHotsiteToPaginaEspecial < ActiveRecord::Migration
  def self.up
    add_column :pagina_especiais, :hotsite, :boolean, :default => false
  end

  def self.down
    remove_column :pagina_especiais, :hotsite
  end
end
