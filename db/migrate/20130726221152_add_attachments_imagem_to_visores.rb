class AddAttachmentsImagemToVisores < ActiveRecord::Migration
  def self.up
    add_column :visores, :imagem_file_name, :string
    add_column :visores, :imagem_content_type, :string
    add_column :visores, :imagem_file_size, :integer
    add_column :visores, :imagem_updated_at, :datetime
  end

  def self.down
    remove_column :visores, :imagem_file_name
    remove_column :visores, :imagem_content_type
    remove_column :visores, :imagem_file_size
    remove_column :visores, :imagem_updated_at
  end
end
