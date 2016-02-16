class CreateOutrasLocalidades < ActiveRecord::Migration
  def self.up
    create_table :outras_localidades do |t|
      t.integer :home_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :outras_localidades
  end
end
