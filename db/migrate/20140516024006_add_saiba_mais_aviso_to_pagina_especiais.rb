class AddSaibaMaisAvisoToPaginaEspeciais < ActiveRecord::Migration
  def self.up
    add_column :pagina_especiais, :saiba_mais_aviso, :string, :default => ""
  end

  def self.down
    remove_column :pagina_especiais, :saiba_mais_aviso
  end
end
