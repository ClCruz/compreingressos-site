class AddAbrirVendaToEspetaculos < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :especificar_data_inicial_de_venda, :boolean
    add_column :espetaculos, :data_inicial_de_venda, :datetime
  end

  def self.down
    remove_column :espetaculos, :data_inicial_de_venda
    remove_column :espetaculos, :especificar_data_inicial_de_venda
  end
end
