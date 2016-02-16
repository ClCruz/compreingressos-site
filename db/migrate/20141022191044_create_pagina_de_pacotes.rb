class CreatePaginaDePacotes < ActiveRecord::Migration
  def self.up
    create_table :pagina_de_pacotes do |t|
      t.text   :nome
      t.string :url
      t.string :mapeamento_de_imagem
      t.integer :altura_de_inicio_da_listagem

      t.timestamps
    end
  end

  def self.down
    drop_table :pagina_de_pacotes
  end
end
