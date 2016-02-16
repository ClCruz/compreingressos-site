class CreateEspetaculosPaginaEspeciais < ActiveRecord::Migration
  def self.up
    create_table :espetaculos_pagina_especiais, :id => false, :force => true do |t|
      t.references :espetaculo
      t.references :pagina_especial
    end
    add_index :espetaculos_pagina_especiais, [:espetaculo_id]
    add_index :espetaculos_pagina_especiais, [:pagina_especial_id]
  end

  def self.down
    drop_table :espetaculos_pagina_especiais
  end
end
