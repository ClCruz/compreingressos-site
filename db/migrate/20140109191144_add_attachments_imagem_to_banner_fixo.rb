class AddAttachmentsImagemToBannerFixo < ActiveRecord::Migration
  def self.up
    add_column :banner_fixos, :imagem_file_name, :string
    add_column :banner_fixos, :imagem_content_type, :string
    add_column :banner_fixos, :imagem_file_size, :integer
    add_column :banner_fixos, :imagem_updated_at, :datetime
  end

  def self.down
    remove_column :banner_fixos, :imagem_file_name
    remove_column :banner_fixos, :imagem_content_type
    remove_column :banner_fixos, :imagem_file_size
    remove_column :banner_fixos, :imagem_updated_at
  end
end
