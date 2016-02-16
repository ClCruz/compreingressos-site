class CreatePacoteFiltrosPacotes < ActiveRecord::Migration
  def self.up
    create_table :pacote_filtros_pacotes, :id => false do |t|
      t.references :pacote
      t.references :pacote_filtro
    end
    add_index :pacote_filtros_pacotes, [:pacote_id, :pacote_filtro_id], :unique => true
  end

  def self.down
    drop_table :pacote_filtros_pacotes
  end
end
