class AddAttachmentsImagemDeFundoToTeatros < ActiveRecord::Migration
  def self.up
    add_column :teatros, :imagem_de_fundo_file_name, :string
    add_column :teatros, :imagem_de_fundo_content_type, :string
    add_column :teatros, :imagem_de_fundo_file_size, :integer
    add_column :teatros, :imagem_de_fundo_updated_at, :datetime
  end

  def self.down
    remove_column :teatros, :imagem_de_fundo_file_name
    remove_column :teatros, :imagem_de_fundo_content_type
    remove_column :teatros, :imagem_de_fundo_file_size
    remove_column :teatros, :imagem_de_fundo_updated_at
  end
end
