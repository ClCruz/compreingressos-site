class CreatePacoteFiltros < ActiveRecord::Migration
  def self.up
    create_table :pacote_filtros do |t|
      t.string :nome
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :pacote_filtros
  end
end
