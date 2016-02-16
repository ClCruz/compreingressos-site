class CreateEspetaculosVisors < ActiveRecord::Migration
  def self.up
    create_table :espetaculos_visors, :id => false do |t|
      t.integer :espetaculo_id
      t.integer :visor_id
    end
    
    add_index :espetaculos_visors, [:espetaculo_id, :visor_id], :unique => true 
    add_index :espetaculos_visors, :visor_id, :unique => false 
  end

  def self.down
    drop_table :espetaculos_visors
  end
end
