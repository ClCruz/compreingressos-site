ActionController::Routing::Routes.draw do |map|
  
  map.resources :publicidades

  map.connect 'espetaculo_ausentes/save', :controller => :espetaculo_ausentes, :action => :save

  map.resources :espetaculo_ausentes

  map.resources :estados

  map.resources :municipios

  map.resources :pagina_especial_banners

  map.resources :pagina_especial_visores

  map.resources :conjunto_cidade_visores

  map.resources :conjunto_cidades

  map.resources :macacos

  map.resources :pacote_filtros

  map.connect 'relatorios/todos_os_espetaculos.:format', :controller => :relatorios, :action => :todos_os_espetaculos

  map.connect 'espetaculo_ausentes/exportar.csv', :controller => :espetaculo_ausentes, :action => :exportar

  map.connect 'relatorios/index', :controller => :relatorios, :action => :index

  map.resources :pagina_especial_filtros

  map.connect 'pacotes/reorganiza', :controller => :pacotes, :action => :reorganiza

  map.connect 'pagina_especial_visor/reorganiza', :controller => :pagina_especial_visores, :action => :reorganiza
  
  map.resources :pacotes
  
  map.connect ':url/assinatura_mobile/:filtro', :controller => :pagina_de_pacotes, :action => :index
  
  map.connect ':url/assinatura_mobile', :controller => :pagina_de_pacotes, :action => :index
  
  map.connect ':url/assinaturas/:filtro', :controller => :pagina_de_pacotes, :action => :index
  
  map.connect ':url/assinaturas', :controller => :pagina_de_pacotes, :action => :index

  map.connect 'pagina_de_pacotes/admin_index', :controller => :pagina_de_pacotes, :action => :admin_index

  map.resources :pagina_de_pacotes

  map.connect 'home_background/excluir', :controller => :home_background, :action => :excluir
  
  map.connect 'home_background/gravar', :controller => :home_background, :action => :gravar
  
  map.connect 'home_background/', :controller => :home_background, :action => :index
  
  map.connect 'cidade_visores/reorganiza', :controller => :cidade_visores, :action => :reorganiza
  
  map.resources :cidade_visores
  
  #map.connect 'pagina_especiais/setaalturadeiniciomobile', :controller => :pagina_especiais, :action => :setaalturadeiniciomobile

  map.connect 'pagina_especiais/show.:format', :controller => :pagina_especiais, :action => :show
  
  map.connect 'pagina_especiais/excluir_img/:id/:tipo', :controller => :pagina_especiais, :action => :excluir_img
 
  map.connect 'pagina/:url', :controller => :pagina_especiais, :action => :show
  
  map.connect 'pagina_especiais/selecionar/:id', :controller => :pagina_especiais, :action => :selecionar
  
  map.resources :pagina_especiais

  map.connect 'banner_fixos/reorganiza', :controller => :banner_fixos, :action => :reorganiza
  
  map.resources :banner_fixos

  map.connect 'app', :controller => :compreingressos, :action => :app

  map.connect 'compreingressos/newsletter', :controller => :compreingressos, :action => :newsletter
  
  map.connect 'home_modulo_espetaculos/reorganiza', :controller => :home_modulo_espetaculos, :action => :reorganiza
  
  map.resources :home_modulo_espetaculos
  
  map.connect 'visores/lista.json', :controller => :visores, :action => :lista

  map.connect 'visores/reorganiza', :controller => :visores, :action => :reorganiza
  
  map.resources :visores
  
  map.connect 'home_modulos/reorganiza', :controller => :home_modulos, :action => :reorganiza

  map.resources :home_modulos

  map.resources :galerias
  
  map.connect 'eventos_realizados/admin_index', :controller => :eventos_realizados, :action => :admin_index
  
  map.resources :eventos_realizados
  
  map.resources :especiais

  map.resources :faqs

  map.connect 'ocorrencias/processadas', :controller => :ocorrencias, :action => :processadas
  map.resources :ocorrencias

  map.connect 'institucional/', :controller => :textos, :action => :show, :id => 1
  map.connect 'politica/', :controller => :textos, :action => :show, :id => 2
  map.connect 'privacidade/', :controller => :textos, :action => :show, :id => 3
  map.connect 'meia-entrada-por-regiao/', :controller => :textos, :action => :show, :id => 5
  
  map.resources :textos

  map.resources :pontosdevenda

  map.connect 'pontosdevendas', :controller => :pontosdevenda, :action => :admin_index

  map.connect 'footer', :controller => :footer, :action => :index
  
  map.resources :videos

  map.connect 'teatros/admin_index', :controller => :teatros, :action => :admin_index
  
  map.resources :servicos

  map.resources :admins
  
  map.connect 'outras_localidades/reorganiza', :controller => :outras_localidades, :action => :reorganiza

  map.resources :outras_localidades
  
  map.connect 'visors/reorganiza', :controller => :visors, :action => :reorganiza
  
  map.connect 'homes/reorganiza', :controller => :homes, :action => :reorganiza

  map.resources :homes

  map.resources :generos

  map.resources :classificacaos
  
  map.connect 'espetaculos/busca.json', :controller => :espetaculos, :action => :busca
  
  map.connect 'espetaculos/busca', :controller => :espetaculos, :action => :busca
  
  #map.connect 'espetaculos/setaalturadeiniciomobile', :controller => :espetaculos, :action => :setaalturadeiniciomobile
  
  #map.connect 'espetaculos/readicionahorarios', :controller => :espetaculos, :action => :readicionahorarios
  
  map.connect 'espetaculos/exportar.csv', :controller => :espetaculos, :action => :exportar
  
  map.connect 'espetaculos/paineis.json', :controller => :espetaculos, :action => :paineis
  
  #map.connect 'espetaculos/atualizaminiaturas', :controller => :espetaculos, :action => :atualizaminiaturas

  map.connect 'espetaculos/excluir_img/:id/:tipo', :controller => :espetaculos, :action => :excluir_img

  map.connect 'espetaculos/datas_gravar', :controller => :espetaculos, :action => :datas_gravar
  
  map.connect 'espetaculos/datas', :controller => :espetaculos, :action => :datas
  
  #map.connect 'espetaculos/thumbnailsconverter', :controller => :espetaculos, :action => :thumbnailsconverter
  
  #map.connect 'espetaculos/resize', :controller => :espetaculos, :action => :resize
  
  #map.connect 'espetaculos/ccminiaturas', :controller => :espetaculos, :action => :ccminiaturas
  
  map.connect 'espetaculos/nobuilder.:format', :controller => :espetaculos, :action => :home
  
  map.connect 'espetaculos/home.:format', :controller => :espetaculos, :action => :home
  
  map.connect 'espetaculos/banners.:format', :controller => :espetaculos, :action => :banners
  
  map.connect 'espetaculos/admin_index', :controller => :espetaculos, :action => :admin_index
  
  map.connect 'espetaculos/banners', :controller => :espetaculos, :action => :banners

  map.resources :espetaculos
  
  #map.connect 'teatros/address_lat_long', :controller => :teatros, :action => :address_lat_long
  
  map.connect 'teatros/resize', :controller => :teatros, :action => :resize
  
  map.resources :teatros
  
  map.connect 'cidades/excluir_img/:id/:tipo', :controller => :cidades, :action => :excluir_img

  map.resources :cidades

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  map.root :controller => 'compreingressos'
  
  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect ':url', :controller => :pagina_especiais, :action => :show
  map.connect ':url/edit', :controller => :pagina_especiais, :action => :edit
end