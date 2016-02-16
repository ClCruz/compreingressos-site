class AddDataDeExpiracaoToVisores < ActiveRecord::Migration
  def self.up
    add_column :visores, :data_de_expiracao, :datetime
  end

  def self.down
    remove_column :visores, :data_de_expiracao
  end
end
