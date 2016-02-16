class CreateBannerFixos < ActiveRecord::Migration
  def self.up
    create_table :banner_fixos do |t|
      t.string :link
      t.boolean :blank
      t.integer :ordem

      t.timestamps
    end
  end

  def self.down
    drop_table :banner_fixos
  end
end
