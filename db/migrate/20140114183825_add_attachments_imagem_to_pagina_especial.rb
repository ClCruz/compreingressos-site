class AddAttachmentsImagemToPaginaEspecial < ActiveRecord::Migration
  def self.up
    add_column :pagina_especiais, :imagem_file_name, :string
    add_column :pagina_especiais, :imagem_content_type, :string
    add_column :pagina_especiais, :imagem_file_size, :integer
    add_column :pagina_especiais, :imagem_updated_at, :datetime
  end

  def self.down
    remove_column :pagina_especiais, :imagem_file_name
    remove_column :pagina_especiais, :imagem_content_type
    remove_column :pagina_especiais, :imagem_file_size
    remove_column :pagina_especiais, :imagem_updated_at
  end
end
