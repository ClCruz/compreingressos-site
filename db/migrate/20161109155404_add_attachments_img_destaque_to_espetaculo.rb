class AddAttachmentsImgDestaqueToEspetaculo < ActiveRecord::Migration
	def self.up
    add_column :espetaculos, :img_destaque_file_name, :string
    add_column :espetaculos, :img_destaque_content_type, :string
    add_column :espetaculos, :img_destaque_file_size, :integer
    add_column :espetaculos, :img_destaque_updated_at, :datetime
  end

  def self.down
    remove_column :espetaculos, :img_destaque_file_name
    remove_column :espetaculos, :img_destaque_content_type
    remove_column :espetaculos, :img_destaque_file_size
    remove_column :espetaculos, :img_destaque_updated_at
  end
end
