class CreateTeatros < ActiveRecord::Migration
  def self.up
    create_table :teatros do |t|
      t.text :nome
      t.string :endereco
      t.text :lotacao
      t.string :telefone
      t.string :bilheteria
      t.string :site
      t.integer :cidade_id
      t.integer :visitas

      t.timestamps
    end
  end

  def self.down
    drop_table :teatros
  end
end
