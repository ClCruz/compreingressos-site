class CreatePaginaEspeciais < ActiveRecord::Migration
  def self.up
    create_table :pagina_especiais do |t|
      t.integer :tipo
      t.string :nome
      t.string :url
      t.boolean :ocultar_cidade
      t.boolean :ocultar_teatro
      t.boolean :ocultar_genero
      t.integer :estilo
      t.integer :altura_de_inicio_da_listagem
      t.string :description
      t.string :keywords
      t.string :cor_de_fundo

      t.timestamps
    end
  end

  def self.down
    drop_table :pagina_especiais
  end
end
