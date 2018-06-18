class CreatePacotes < ActiveRecord::Migration
  def self.up
    create_table :pacotes do |t|
      t.string :nome
      t.references :pagina_de_pacote

      t.timestamps
    end
  end

  def self.down
    drop_table :pacotes
  end
end
