class EspetaculosPaginaEspecialFiltros < ActiveRecord::Migration
  def self.up
    create_table :espetaculos_pagina_especial_filtros, :id => false do |t|
      t.integer :espetaculo_id
      t.integer :pagina_especial_filtro_id
    end
    add_index :espetaculos_pagina_especial_filtros, [:espetaculo_id, :pagina_especial_filtro_id], :unique => true
  end

  def self.down
    drop_table :espetaculos_pagina_especial_filtros
  end
end
