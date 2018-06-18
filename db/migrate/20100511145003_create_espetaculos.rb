class CreateEspetaculos < ActiveRecord::Migration
  def self.up
    create_table :espetaculos do |t|
      t.string :nome
      t.text :sinopse
      t.string :temporada
      t.string :horario
      t.string :preco
      t.string :site
      t.boolean :ativo
      t.integer :ticket_net_id

      t.timestamps
    end
  end

  def self.down
    drop_table :espetaculos
  end
end
