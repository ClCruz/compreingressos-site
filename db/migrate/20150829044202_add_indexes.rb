class AddIndexes < ActiveRecord::Migration
  def self.up
    #add_index :accounts, [:branch_id, :party_id], :unique => true, :name => 'by_branch_party'
    add_index :banner_fixos, :ordem
    add_index :cidade_visores, :cidade_id
    add_index :cidade_visores, :ordem
    add_index :cidades, :nome
    add_index :cidades, :estado
    add_index :entradas, :asset_id
    add_index :espetaculos, :cc_id
    add_index :espetaculos, :teatro_id
    add_index :espetaculos, :genero_id
    add_index :espetaculos, :classificacao_id
    add_index :espetaculos, :ativo
    add_index :espetaculos, :especial
    add_index :espetaculos, :privado
    add_index :espetaculos, :relevancia
    add_index :espetaculos_homes, [:espetaculo_id, :home_id]
    add_index :espetaculos_homes, :ordem
    add_index :espetaculos_outras_localidades, [:espetaculo_id, :outras_localidade_id], :name => "index_by_espetaculo_localidade"
    add_index :espetaculos_outras_localidades, :ordem
    add_index :espetaculos_pagina_especiais, [:espetaculo_id, :pagina_especial_id], :name => "index_by_espetaculo_pagina_especial"#, :unique => true # Poderia ser mas tenho que testar para confirmar
    add_index :espetaculos_visors, [:espetaculo_id, :visor_id]
    add_index :espetaculos_visors, :ordem
    add_index :eventos_realizados, :espetaculo_id
    add_index :eventos_realizados, :ordem
    add_index :galerias, :espetaculo_id
    add_index :galerias, :ordem
    add_index :home_modulo_espetaculos, [:home_modulo_id, :espetaculo_id], :name => "index_by_home_modulo_espetaculo"
    add_index :home_modulo_espetaculos, :ordem
    add_index :home_modulos, :ordem
    add_index :homes, :cidade_id
    add_index :horarios, :espetaculo_id
    add_index :horarios, :data
    add_index :imagems, :asset_id
    add_index :outras_localidades, :home_id
    add_index :pacotes, :pagina_de_pacote_id
    add_index :pacotes, :cc_id
    add_index :pacotes, :teatro_id
    add_index :pacotes, :ordem
    add_index :pacotes_espetaculos, [:pacote_id, :espetaculo_id]
    add_index :pacotes_espetaculos, :data
    add_index :pagina_de_pacotes, :url
    add_index :pagina_especiais, :url
    add_index :teatro_imagens, :teatro_id
    add_index :teatro_imagens, :ordem
    add_index :teatros, :cidade_id
    add_index :videos, :asset_id
    add_index :visores, :order
  end

  def self.down
    #remove_index :accounts, :name => :by_branch_party
    remove_index :banner_fixos, :ordem
    remove_index :cidade_visores, :cidade_id
    remove_index :cidade_visores, :ordem
    remove_index :cidades, :nome
    remove_index :cidades, :estado
    remove_index :entradas, :asset_id
    remove_index :espetaculos, :cc_id
    remove_index :espetaculos, :teatro_id
    remove_index :espetaculos, :genero_id
    remove_index :espetaculos, :classificacao_id
    remove_index :espetaculos, :ativo
    remove_index :espetaculos, :especial
    remove_index :espetaculos, :privado
    remove_index :espetaculos, :relevancia
    remove_index :espetaculos_homes, [:espetaculo_id, :home_id]
    remove_index :espetaculos_homes, :ordem
    remove_index :espetaculos_outras_localidades, :name => "index_by_espetaculo_localidade"
    remove_index :espetaculos_outras_localidades, :ordem
    remove_index :espetaculos_pagina_especiais, :name => "index_by_espetaculo_pagina_especial"
    remove_index :espetaculos_visors, [:espetaculo_id, :visor_id]
    remove_index :espetaculos_visors, :ordem
    remove_index :eventos_realizados, :espetaculo_id
    remove_index :eventos_realizados, :ordem
    remove_index :galerias, :espetaculo_id
    remove_index :galerias, :ordem
    remove_index :home_modulo_espetaculos, :name => "index_by_home_modulo_espetaculo"
    remove_index :home_modulo_espetaculos, :ordem
    remove_index :home_modulos, :ordem
    remove_index :homes, :cidade_id
    remove_index :horarios, :espetaculo_id
    remove_index :horarios, :data
    remove_index :imagems, :asset_id
    remove_index :outras_localidades, :home_id
    remove_index :pacotes, :pagina_de_pacote_id
    remove_index :pacotes, :cc_id
    remove_index :pacotes, :teatro_id
    remove_index :pacotes, :ordem
    remove_index :pacotes_espetaculos, [:pacote_id, :espetaculo_id]
    remove_index :pacotes_espetaculos, :data
    remove_index :pagina_de_pacotes, :url
    remove_index :pagina_especiais, :url
    remove_index :teatro_imagens, :teatro_id
    remove_index :teatro_imagens, :ordem
    remove_index :teatros, :cidade_id
    remove_index :videos, :asset_id
    remove_index :visores, :order
  end
end
