class CreateEspetaculosHomes < ActiveRecord::Migration
  def self.up
    create_table :espetaculos_homes, :id => false do |t|
      t.integer :espetaculo_id
      t.integer :home_id
    end
    
    add_index :espetaculos_homes, [:espetaculo_id, :home_id], :unique => true 
    add_index :espetaculos_homes, :home_id, :unique => false 
  end

  def self.down
    drop_table :espetaculos_homes
  end
end
