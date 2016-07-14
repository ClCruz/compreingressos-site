# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20160711130245) do

  create_table "admins", :force => true do |t|
    t.string   "nome"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banner_fixos", :force => true do |t|
    t.string   "link"
    t.boolean  "blank"
    t.integer  "ordem"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
  end

  add_index "banner_fixos", ["ordem"], :name => "index_banner_fixos_on_ordem"

  create_table "cidade_visores", :force => true do |t|
    t.integer  "cidade_id"
    t.string   "link"
    t.boolean  "blank"
    t.integer  "ordem"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
  end

  add_index "cidade_visores", ["cidade_id"], :name => "index_cidade_visores_on_cidade_id"
  add_index "cidade_visores", ["ordem"], :name => "index_cidade_visores_on_ordem"

  create_table "cidades", :force => true do |t|
    t.string   "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nome"
    t.string   "cor_de_fundo"
    t.integer  "altura_de_inicio"
    t.text     "mapeamento_de_imagem"
    t.string   "imagem_de_fundo_file_name"
    t.string   "imagem_de_fundo_content_type"
    t.integer  "imagem_de_fundo_file_size"
    t.datetime "imagem_de_fundo_updated_at"
    t.string   "cor_de_fundo_do_box"
    t.string   "cor_de_texto_do_box"
    t.string   "cor_de_link_do_box"
    t.string   "cor_da_borda_do_espetaculo"
    t.string   "cor_do_header"
    t.string   "cor_da_borda_do_header"
    t.boolean  "parallax"
    t.string   "parallax_valor"
  end

  add_index "cidades", ["estado"], :name => "index_cidades_on_estado"
  add_index "cidades", ["nome"], :name => "index_cidades_on_nome"

  create_table "cidades_conjunto_cidades", :id => false, :force => true do |t|
    t.integer "conjunto_cidade_id"
    t.integer "cidade_id"
  end

  create_table "classificacaos", :force => true do |t|
    t.string   "nome"
    t.string   "texto"
    t.string   "icone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conjunto_cidade_visores", :force => true do |t|
    t.integer  "conjunto_cidade_id"
    t.string   "link"
    t.boolean  "blank"
    t.integer  "ordem"
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conjunto_cidades", :force => true do |t|
    t.string   "nome"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cor_de_fundo"
    t.string   "imagem_de_fundo_file_name"
    t.string   "imagem_de_fundo_content_type"
    t.string   "cor_de_fundo_do_box"
    t.string   "cor_de_texto_do_box"
    t.string   "cor_de_link_do_box"
    t.string   "cor_da_borda_do_espetaculo"
    t.string   "cor_do_header"
    t.string   "cor_da_borda_do_header"
    t.string   "parallax_valor"
    t.integer  "imagem_de_fundo_file_size"
    t.integer  "altura_de_inicio"
    t.boolean  "parallax"
    t.text     "mapeamento_de_imagem"
    t.datetime "imagem_de_fundo_updated_at"
  end

  create_table "entradas", :force => true do |t|
    t.string   "atributo"
    t.text     "valor"
    t.integer  "asset_id"
    t.string   "asset_type"
    t.boolean  "pequeno",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entradas", ["asset_id"], :name => "index_entradas_on_asset_id"

  create_table "especiais", :force => true do |t|
    t.string   "titulo"
    t.string   "subtitulo"
    t.string   "titulo_left"
    t.text     "subtitulo_left"
    t.text     "texto"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "espetaculo_ausentes", :force => true do |t|
    t.string   "email"
    t.string   "artista"
    t.string   "estilo"
    t.integer  "municipio_id"
    t.boolean  "aceita_noticia"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "espetaculos", :force => true do |t|
    t.text     "nome"
    t.text     "sinopse"
    t.string   "temporada"
    t.string   "horario"
    t.string   "preco"
    t.string   "site"
    t.boolean  "ativo"
    t.integer  "ticket_net_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "teatro_id"
    t.integer  "classificacao_id"
    t.integer  "genero_id"
    t.string   "keywords"
    t.string   "description"
    t.boolean  "mais_vendido"
    t.integer  "visitas",                                         :default => 0
    t.integer  "cc_id"
    t.integer  "aba_inicial"
    t.date     "data_maxima"
    t.boolean  "privado",                                         :default => false
    t.integer  "relevancia",                                      :default => 1
    t.text     "desconto"
    t.date     "data_inicial"
    t.string   "duracao",                           :limit => 50
    t.string   "img_principal_file_name"
    t.string   "img_principal_content_type"
    t.integer  "img_principal_file_size"
    t.datetime "img_principal_updated_at"
    t.string   "img_miniatura_file_name"
    t.string   "img_miniatura_content_type"
    t.integer  "img_miniatura_file_size"
    t.datetime "img_miniatura_updated_at"
    t.integer  "img_miniatura_height"
    t.boolean  "especial"
    t.string   "cor_de_fundo"
    t.integer  "altura_de_inicio"
    t.string   "fundo_file_name"
    t.string   "fundo_content_type"
    t.integer  "fundo_file_size"
    t.datetime "fundo_updated_at"
    t.string   "cor_de_fundo_do_box"
    t.string   "cor_do_texto_do_box"
    t.string   "cor_do_link_do_box"
    t.string   "cor_da_borda_do_box"
    t.string   "cor_do_texto_do_cabecalho"
    t.string   "cor_do_link_do_cabecalho"
    t.string   "cor_da_borda_das_imagens"
    t.integer  "cor_dos_botoes"
    t.integer  "altura_de_inicio_mobile"
    t.datetime "horario_cache"
    t.boolean  "especificar_data_inicial_de_venda"
    t.datetime "data_inicial_de_venda"
    t.string   "texto_de_link_do_redirecionamento"
    t.string   "link_do_redirecionamento"
    t.boolean  "blank_de_link_do_redirecionamento"
  end

  add_index "espetaculos", ["ativo"], :name => "index_espetaculos_on_ativo"
  add_index "espetaculos", ["cc_id"], :name => "index_espetaculos_on_cc_id"
  add_index "espetaculos", ["classificacao_id"], :name => "index_espetaculos_on_classificacao_id"
  add_index "espetaculos", ["especial"], :name => "index_espetaculos_on_especial"
  add_index "espetaculos", ["genero_id"], :name => "index_espetaculos_on_genero_id"
  add_index "espetaculos", ["privado"], :name => "index_espetaculos_on_privado"
  add_index "espetaculos", ["relevancia"], :name => "index_espetaculos_on_relevancia"
  add_index "espetaculos", ["teatro_id"], :name => "index_espetaculos_on_teatro_id"

  create_table "espetaculos_homes", :force => true do |t|
    t.integer "ordem",         :default => 0, :null => false
    t.integer "espetaculo_id"
    t.integer "home_id"
  end

  add_index "espetaculos_homes", ["espetaculo_id", "home_id"], :name => "index_espetaculos_homes_on_espetaculo_id_and_home_id"
  add_index "espetaculos_homes", ["ordem"], :name => "index_espetaculos_homes_on_ordem"

  create_table "espetaculos_outras_localidades", :force => true do |t|
    t.integer "espetaculo_id"
    t.integer "outras_localidade_id"
    t.integer "ordem"
  end

  add_index "espetaculos_outras_localidades", ["espetaculo_id", "outras_localidade_id"], :name => "index_by_espetaculo_localidade"
  add_index "espetaculos_outras_localidades", ["ordem"], :name => "index_espetaculos_outras_localidades_on_ordem"

  create_table "espetaculos_pagina_especiais", :id => false, :force => true do |t|
    t.integer "espetaculo_id"
    t.integer "pagina_especial_id"
  end

  add_index "espetaculos_pagina_especiais", ["espetaculo_id", "pagina_especial_id"], :name => "index_by_espetaculo_pagina_especial"

  create_table "espetaculos_pagina_especial_filtros", :id => false, :force => true do |t|
    t.integer "espetaculo_id"
    t.integer "pagina_especial_filtro_id"
  end

  create_table "espetaculos_visors", :force => true do |t|
    t.integer "espetaculo_id"
    t.integer "visor_id"
    t.integer "ordem"
  end

  add_index "espetaculos_visors", ["espetaculo_id", "visor_id"], :name => "index_espetaculos_visors_on_espetaculo_id_and_visor_id"
  add_index "espetaculos_visors", ["ordem"], :name => "index_espetaculos_visors_on_ordem"

  create_table "estados", :force => true do |t|
    t.string   "nome"
    t.string   "sigla"
    t.integer  "regiao_geografica_id"
    t.integer  "pais_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eventos_realizados", :force => true do |t|
    t.string  "temporada",                   :null => false
    t.string  "ordem",         :limit => 10, :null => false
    t.integer "espetaculo_id",               :null => false
  end

  add_index "eventos_realizados", ["espetaculo_id"], :name => "index_eventos_realizados_on_espetaculo_id"
  add_index "eventos_realizados", ["ordem"], :name => "index_eventos_realizados_on_ordem"

  create_table "faqs", :force => true do |t|
    t.string   "titulo"
    t.string   "subtitulo"
    t.text     "texto"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galerias", :force => true do |t|
    t.string   "legenda"
    t.integer  "espetaculo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.integer  "ordem"
  end

  add_index "galerias", ["espetaculo_id"], :name => "index_galerias_on_espetaculo_id"
  add_index "galerias", ["ordem"], :name => "index_galerias_on_ordem"

  create_table "generos", :force => true do |t|
    t.string   "nome"
    t.string   "icone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "home_backgrounds", :force => true do |t|
    t.string  "bgcolor"
    t.string  "cor_de_texto"
    t.boolean "esquerda_blank"
    t.string  "esquerda_link"
    t.boolean "direita_blank"
    t.string  "direita_link"
  end

  create_table "home_modulo_espetaculos", :force => true do |t|
    t.integer  "home_modulo_id"
    t.integer  "espetaculo_id"
    t.integer  "ordem"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "home_modulo_espetaculos", ["home_modulo_id", "espetaculo_id"], :name => "index_by_home_modulo_espetaculo"
  add_index "home_modulo_espetaculos", ["ordem"], :name => "index_home_modulo_espetaculos_on_ordem"

  create_table "home_modulos", :force => true do |t|
    t.string   "titulo"
    t.datetime "entrada"
    t.datetime "saida"
    t.integer  "ordem"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tipo"
    t.integer  "exibir"
    t.boolean  "ocultar_cidade",      :default => false
    t.boolean  "ocultar_teatro",      :default => false
    t.boolean  "ocultar_genero",      :default => false
    t.string   "link"
    t.boolean  "blank"
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.boolean  "topo"
    t.integer  "imagem_altura"
  end

  add_index "home_modulos", ["ordem"], :name => "index_home_modulos_on_ordem"

  create_table "homes", :force => true do |t|
    t.integer  "cidade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "homes", ["cidade_id"], :name => "index_homes_on_cidade_id"

  create_table "horarios", :id => false, :force => true do |t|
    t.datetime "data"
    t.integer  "espetaculo_id"
    t.integer  "id_apresentacao"
  end

  add_index "horarios", ["data"], :name => "index_horarios_on_data"
  add_index "horarios", ["espetaculo_id"], :name => "index_horarios_on_espetaculo_id"

  create_table "imagems", :force => true do |t|
    t.string   "nome"
    t.string   "legenda"
    t.string   "content_type"
    t.integer  "asset_id"
    t.string   "asset_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "imagems", ["asset_id"], :name => "index_imagems_on_asset_id"

  create_table "intensivamedcontadors", :force => true do |t|
    t.integer "total"
  end

  create_table "macacos", :force => true do |t|
    t.string   "nome"
    t.float    "comprimento_rabo"
    t.integer  "idade"
    t.boolean  "ativo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "municipios", :force => true do |t|
    t.string   "nome"
    t.integer  "estado_id"
    t.integer  "pais_id"
    t.integer  "nr_habitantes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ocorrencias", :force => true do |t|
    t.integer  "atendente_id"
    t.string   "adquiridos"
    t.date     "data_compra"
    t.integer  "numero_pedido"
    t.string   "nome"
    t.string   "email"
    t.integer  "espetaculo_id"
    t.date     "data_ingressos"
    t.string   "horario"
    t.text     "lugares"
    t.string   "telefone"
    t.string   "tipo_solicitacao"
    t.integer  "protocolo_cancelamento"
    t.integer  "inteira"
    t.integer  "meia"
    t.integer  "outros"
    t.text     "obs"
    t.boolean  "concordancia"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "processada"
    t.date     "nova_data"
    t.string   "novo_horario"
    t.text     "novo_lugar"
    t.string   "valor_servico"
    t.string   "valor_estorno"
    t.string   "status"
  end

  create_table "outras_localidades", :force => true do |t|
    t.integer  "home_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "outras_localidades", ["home_id"], :name => "index_outras_localidades_on_home_id"

  create_table "pacote_filtros", :force => true do |t|
    t.string   "nome"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pacote_filtros_pacotes", :id => false, :force => true do |t|
    t.integer "pacote_id"
    t.integer "pacote_filtro_id"
  end

  add_index "pacote_filtros_pacotes", ["pacote_id", "pacote_filtro_id"], :name => "index_pacote_filtros_pacotes_on_pacote_id_and_pacote_filtro_id", :unique => true

  create_table "pacotes", :force => true do |t|
    t.string   "nome"
    t.integer  "pagina_de_pacote_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cc_id"
    t.text     "setores"
    t.integer  "ordem"
    t.integer  "cc_evento_id"
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.text     "descricao"
  end

  add_index "pacotes", ["cc_id"], :name => "index_pacotes_on_cc_id"
  add_index "pacotes", ["ordem"], :name => "index_pacotes_on_ordem"
  add_index "pacotes", ["pagina_de_pacote_id"], :name => "index_pacotes_on_pagina_de_pacote_id"

  create_table "pacotes_espetaculos", :force => true do |t|
    t.integer  "pacote_id"
    t.integer  "espetaculo_id"
    t.datetime "data"
    t.string   "nome_do_espetaculo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pacotes_espetaculos", ["data"], :name => "index_pacotes_espetaculos_on_data"
  add_index "pacotes_espetaculos", ["pacote_id", "espetaculo_id"], :name => "index_pacotes_espetaculos_on_pacote_id_and_espetaculo_id"

  create_table "pagina_de_pacotes", :force => true do |t|
    t.text     "nome"
    t.string   "url"
    t.string   "mapeamento_de_imagem"
    t.integer  "altura_de_inicio_da_listagem"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.string   "subtitulo"
    t.string   "cor_do_header"
    t.string   "cor_de_fundo"
  end

  add_index "pagina_de_pacotes", ["url"], :name => "index_pagina_de_pacotes_on_url"

  create_table "pagina_especiais", :force => true do |t|
    t.integer  "tipo"
    t.string   "nome"
    t.string   "url"
    t.boolean  "ocultar_cidade"
    t.boolean  "ocultar_teatro"
    t.boolean  "ocultar_genero"
    t.integer  "altura_de_inicio_da_listagem"
    t.string   "description"
    t.string   "keywords"
    t.string   "cor_de_fundo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.string   "cor_de_fundo_do_box"
    t.string   "cor_do_texto_do_box"
    t.string   "cor_do_link_do_box"
    t.string   "cor_da_borda_do_espetaculo"
    t.integer  "organizado_por",                      :default => 1
    t.integer  "tipo_de_botao",                       :default => 1
    t.text     "mapeamento_de_imagem"
    t.boolean  "filtro_cidade",                       :default => false
    t.boolean  "filtro_genero",                       :default => false
    t.boolean  "busca",                               :default => false
    t.string   "saiba_mais_aviso",                    :default => ""
    t.string   "cor_do_header",                       :default => ""
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "cor_da_borda_do_header"
    t.integer  "nome_tamanho_da_fonte"
    t.integer  "altura_de_inicio_da_listagem_mobile", :default => 0
    t.string   "texto_de_link_do_regulamento"
    t.string   "link_do_regulamento"
    t.string   "cor_de_link_do_regulamento"
    t.boolean  "blank_de_link_do_regulamento"
  end

  add_index "pagina_especiais", ["url"], :name => "index_pagina_especiais_on_url"

  create_table "pagina_especial_banners", :force => true do |t|
    t.integer  "pagina_especial_id"
    t.string   "link"
    t.boolean  "blank"
    t.integer  "ordem"
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pagina_especial_filtros", :force => true do |t|
    t.string   "nome"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pagina_especial_filtros", ["nome"], :name => "index_pagina_especial_filtros_on_nome", :unique => true
  add_index "pagina_especial_filtros", ["url"], :name => "index_pagina_especial_filtros_on_url", :unique => true

  create_table "pagina_especial_visores", :force => true do |t|
    t.integer  "pagina_especial_id"
    t.string   "link"
    t.boolean  "blank"
    t.integer  "ordem"
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pontosdevenda", :force => true do |t|
    t.string   "titulo"
    t.text     "texto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cidade_id"
  end

  create_table "publicidades", :force => true do |t|
    t.string   "nome"
    t.integer  "tempo_de_exibicao"
    t.string   "link"
    t.text     "script"
    t.boolean  "blank"
    t.integer  "ordem"
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.boolean  "status"
    t.date     "data_inicio"
    t.date     "data_fim"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "servicos", :force => true do |t|
    t.string   "titulo"
    t.string   "subtitulo"
    t.text     "texto"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "teatro_imagens", :force => true do |t|
    t.integer  "teatro_id"
    t.integer  "ordem"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
  end

  add_index "teatro_imagens", ["ordem"], :name => "index_teatro_imagens_on_ordem"
  add_index "teatro_imagens", ["teatro_id"], :name => "index_teatro_imagens_on_teatro_id"

  create_table "teatros", :force => true do |t|
    t.text     "nome"
    t.string   "endereco"
    t.text     "lotacao"
    t.string   "telefone"
    t.string   "bilheteria"
    t.string   "site"
    t.integer  "cidade_id"
    t.integer  "visitas",                      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bairro"
    t.string   "keywords"
    t.string   "description"
    t.string   "aba_inicial"
    t.boolean  "ativo",                        :default => true
    t.integer  "relevancia",                   :default => 1
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.string   "cor_de_fundo"
    t.integer  "altura_de_inicio"
    t.string   "cor_do_texto"
    t.string   "cor_da_borda_dos_boxes"
    t.string   "cor_do_fundo_dos_boxes"
    t.string   "cor_do_texto_dos_boxes"
    t.string   "imagem_de_fundo_file_name"
    t.string   "imagem_de_fundo_content_type"
    t.integer  "imagem_de_fundo_file_size"
    t.datetime "imagem_de_fundo_updated_at"
    t.string   "mapa_de_plateia_file_name"
    t.string   "mapa_de_plateia_content_type"
    t.integer  "mapa_de_plateia_file_size"
    t.datetime "mapa_de_plateia_updated_at"
    t.boolean  "parallax"
    t.string   "parallax_valor"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "ordenacao_dos_espetaculos",    :default => 1
  end

  add_index "teatros", ["cidade_id"], :name => "index_teatros_on_cidade_id"

  create_table "textos", :force => true do |t|
    t.string   "titulo"
    t.string   "subtitulo"
    t.text     "texto"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.string   "titulo"
    t.string   "legenda"
    t.string   "youtube_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "asset_id"
    t.string   "asset_type"
  end

  add_index "videos", ["asset_id"], :name => "index_videos_on_asset_id"

  create_table "visores", :force => true do |t|
    t.string   "link"
    t.boolean  "blank"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.datetime "data_de_expiracao"
    t.string   "imagem_mobile_file_name"
    t.string   "imagem_mobile_content_type"
    t.integer  "imagem_mobile_file_size"
    t.datetime "imagem_mobile_updated_at"
    t.string   "descricao"
    t.string   "posicao"
    t.string   "grupo"
  end

  add_index "visores", ["order"], :name => "index_visores_on_order"

end
