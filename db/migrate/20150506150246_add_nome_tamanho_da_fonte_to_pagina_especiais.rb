class AddNomeTamanhoDaFonteToPaginaEspeciais < ActiveRecord::Migration
  def self.up
    add_column :pagina_especiais, :nome_tamanho_da_fonte, :integer
  end

  def self.down
    remove_column :pagina_especiais, :nome_tamanho_da_fonte
  end
end
