class CreateVisores < ActiveRecord::Migration
  def self.up
    create_table :visores do |t|
      t.string :link
      t.boolean :blank
      t.integer :order

      t.timestamps
    end
  end

  def self.down
    drop_table :visores
  end
end
