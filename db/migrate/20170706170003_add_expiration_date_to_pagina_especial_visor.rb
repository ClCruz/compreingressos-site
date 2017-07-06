class AddExpirationDateToPaginaEspecialVisor < ActiveRecord::Migration
  def self.up
    add_column :pagina_especial_visores, :data_de_expiracao, :datetime
  end

  def self.down
    remove_column :pagina_especial_visores, :data_de_expiracao, :datetime
  end
end

