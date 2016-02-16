class AddImgMiniaturaHeightToEspetaculos < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :img_miniatura_height, :integer
  end

  def self.down
    remove_column :espetaculos, :img_miniatura_height
  end
end
