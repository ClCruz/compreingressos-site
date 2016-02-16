class CreateImagems < ActiveRecord::Migration
  def self.up
    create_table :imagems do |t|
      t.string :nome
      t.string :legenda
      t.string :content_type
      t.integer :asset_id
      t.string :asset_type

      t.timestamps
    end
  end

  def self.down
    drop_table :imagems
  end
end
