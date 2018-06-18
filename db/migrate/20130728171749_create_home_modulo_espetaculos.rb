class CreateHomeModuloEspetaculos < ActiveRecord::Migration
  def self.up
    create_table :home_modulo_espetaculos do |t|
      t.references :home_modulo
      t.references :espetaculo
      t.integer :ordem

      t.timestamps
    end
  end

  def self.down
    drop_table :home_modulo_espetaculos
  end
end
