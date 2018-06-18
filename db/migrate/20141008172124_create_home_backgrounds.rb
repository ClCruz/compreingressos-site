class CreateHomeBackgrounds < ActiveRecord::Migration
  def self.up
    create_table :home_backgrounds do |t|
      t.string :bgcolor
    end
  end

  def self.down
    drop_table :home_backgrounds
  end
end
