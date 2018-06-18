# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.14' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install  
  config.gem 'abstract',              :version => '1.0.0'
  config.gem 'actionmailer',          :version => '2.3.14'
  config.gem 'actionpack',            :version => '2.3.14'
  config.gem 'activerecord',          :version => '2.3.14'
  config.gem 'activeresource',        :version => '2.3.14'
  config.gem 'activesupport',         :version => '2.3.14'
  config.gem 'after_commit',          :version => '1.0.10'
  config.gem 'arel',                  :version => '2.0.10'
  config.gem 'atomic',                :version => '1.1.10'
  config.gem 'builder',               :version => '2.1.2'
  config.gem 'cgi_multipart_eof_fix', :version => '2.5.0'
  config.gem 'chronic',               :version => '0.10.2'
  config.gem 'daemon_controller',     :version => '1.2.0'
  config.gem 'daemons',               :version => '1.1.2'
  config.gem 'erubis',                :version => '2.6.6'
  config.gem 'fastthread',            :version => '1.0.7'
  config.gem 'gem_plugin',            :version => '0.2.3'
  config.gem 'geocoder',              :version => '1.1.9'
  config.gem 'geoip',                 :version => '1.4.0'
  config.gem 'geokit',                :version => '1.6.5'
  config.gem 'geokit-rails',          :version => '1.1.4'
  config.gem 'gibbon',                :version => '1.1.2'
  config.gem 'hpricot',               :version => '0.8.6'
  config.gem 'httparty',              :version => '0.11.0'
  config.gem 'i18n',                  :version => '0.6.11'
  #config.gem 'json',                  :version => '1.8.1'
  #config.gem 'mail',                  :version => '2.2.20'
  config.gem 'mime-types',            :version => '1.25.1'
  config.gem 'mini_magick',           :version => '3.2'
  config.gem 'minitest',              :version => '5.4.3'
  config.gem 'multi_json',            :version => '1.11.2'
  config.gem 'multi_xml',             :version => '0.5.5'
  config.gem 'mysql',                 :version => '2.8.1'
  config.gem 'newrelic_rpm',          :version => '3.12.1.298'
  config.gem 'paperclip',             :version => '2.3.9'
  config.gem 'polyglot',              :version => '0.3.5'
  config.gem 'rack',                  :version => '1.1.6'
  config.gem 'rails',                 :version => '2.3.14'
  config.gem 'rake',                  :version => '10.1.1'
  config.gem 'rdoc',                  :version => '3.12'
  config.gem 'riddle',                :version => '1.5.3'
  config.gem 'rvm',                   :version => '1.11.3.9'
  config.gem 'sqlite3',               :version => '1.3.10'
  config.gem 'subexec',               :version => '0.0.4'
  config.gem 'thinking-sphinx',       :version => '1.4.12'
  config.gem 'thor',                  :version => '0.14.6'
  config.gem 'thread_safe',           :version => '0.3.4'
  config.gem 'treetop',               :version => '1.4.15'
  config.gem 'tzinfo',                :version => '0.3.45'
  #config.gem 'webrick',               :version => '1.3.1'
  config.gem 'whenever',              :version => '0.9.4'

  config.i18n.enforce_available_locales = false

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
  config.log_level = :debug

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'
  #config.time_zone = 'Brasilia'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  config.i18n.default_locale = :pt
  #config.filter_parameters += [:senha]
end
