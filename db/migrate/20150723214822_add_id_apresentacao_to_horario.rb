class AddIdApresentacaoToHorario < ActiveRecord::Migration
  def self.up
    add_column :horarios, :id_apresentacao, :integer
  end

  def self.down
    remove_column :horarios, :id_apresentacao
  end
end
