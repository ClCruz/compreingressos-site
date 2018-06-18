class CreateEspetaculosOutrasLocalidades < ActiveRecord::Migration
  def self.up
    create_table :espetaculos_outras_localidades, :id => false do |t|
      t.integer :espetaculo_id
      t.integer :outras_localidade_id
    end
    
    add_index :espetaculos_outras_localidades, [:espetaculo_id, :outras_localidade_id], :unique => true 
    add_index :espetaculos_outras_localidades, :outras_localidade_id, :unique => false 
  end

  def self.down
    drop_table :espetaculos_outras_localidades
  end
end
