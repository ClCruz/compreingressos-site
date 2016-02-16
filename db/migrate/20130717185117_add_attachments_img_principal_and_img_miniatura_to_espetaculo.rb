class AddAttachmentsImgPrincipalAndImgMiniaturaToEspetaculo < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :img_principal_file_name, :string
    add_column :espetaculos, :img_principal_content_type, :string
    add_column :espetaculos, :img_principal_file_size, :integer
    add_column :espetaculos, :img_principal_updated_at, :datetime
    add_column :espetaculos, :img_miniatura_file_name, :string
    add_column :espetaculos, :img_miniatura_content_type, :string
    add_column :espetaculos, :img_miniatura_file_size, :integer
    add_column :espetaculos, :img_miniatura_updated_at, :datetime
  end

  def self.down
    remove_column :espetaculos, :img_principal_file_name
    remove_column :espetaculos, :img_principal_content_type
    remove_column :espetaculos, :img_principal_file_size
    remove_column :espetaculos, :img_principal_updated_at
    remove_column :espetaculos, :img_miniatura_file_name
    remove_column :espetaculos, :img_miniatura_content_type
    remove_column :espetaculos, :img_miniatura_file_size
    remove_column :espetaculos, :img_miniatura_updated_at
  end
end
