class CreateClassificacaos < ActiveRecord::Migration
  def self.up
    create_table :classificacaos do |t|
      t.string :nome
      t.string :texto
      t.string :icone

      t.timestamps
    end
  end

  def self.down
    drop_table :classificacaos
  end
end
