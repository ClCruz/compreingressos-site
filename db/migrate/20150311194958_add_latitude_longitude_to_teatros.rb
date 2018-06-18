class AddLatitudeLongitudeToTeatros < ActiveRecord::Migration
  def self.up
    add_column :teatros, :latitude, :float
    add_column :teatros, :longitude, :float
  end

  def self.down
    remove_column :teatros, :longitude
    remove_column :teatros, :latitude
  end
end
