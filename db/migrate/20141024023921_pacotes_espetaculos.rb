class PacotesEspetaculos < ActiveRecord::Migration
  def self.up
    create_table :pacotes_espetaculos do |t|
      t.references :pacote
      t.references :espetaculo
      t.datetime :data
      t.string :nome_do_espetaculo

      t.timestamps
    end
  end

  def self.down
    drop_table :pacotes_espetaculos
  end
end
