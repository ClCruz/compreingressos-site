class CreateEspetaculoAusentes < ActiveRecord::Migration
  def self.up
    create_table :espetaculo_ausentes do |t|
      t.integer :id
      t.string :email
      t.string :artista
      t.string :estilo
      t.references :municipio
      t.boolean :aceita_noticia

      t.timestamps
    end
  end

  def self.down
    drop_table :espetaculo_ausentes
  end
end
