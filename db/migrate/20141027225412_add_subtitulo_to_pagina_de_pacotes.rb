class AddSubtituloToPaginaDePacotes < ActiveRecord::Migration
  def self.up
    add_column :pagina_de_pacotes, :subtitulo, :string
  end

  def self.down
    remove_column :pagina_de_pacotes, :subtitulo
  end
end
