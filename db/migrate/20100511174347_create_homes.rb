class CreateHomes < ActiveRecord::Migration
  def self.up
    create_table :homes do |t|
      t.integer :cidade_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :homes
  end
end
