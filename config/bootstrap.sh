apt-get update
apt-get upgrade

dd if=/dev/zero of=/swap bs=1M count=1024
mkswap /swap
swapon /swap

# rvm + ruby 1.8.7
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable --ruby=1.8.7

source /usr/local/rvm/scripts/rvm

rvm 1.8.7
rvm rubygems 1.8.7 --force

export rvmsudo_secure_path=1

# mysql
debconf-set-selections <<< 'mysql-server mysql-server/root_password password 123'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 123'
apt-get -y install mysql-server

# update rubygems
rvmsudo gem install rubygems-update -v 1.8.7 --no-ri --no-RDoc
update_rubygems

# rails
rvmsudo gem install rake -v 10.1.1 --no-ri --no-RDoc
rvmsudo gem install rails -v 2.3.14 --no-ri --no-RDoc

# other gems
rvmsudo gem install multi_json -v 1.11.2 --no-ri --no-RDoc
rvmsudo gem install abstract -v 1.0.0 --no-ri --no-RDoc
rvmsudo gem install after_commit -v 1.0.10 --no-ri --no-RDoc
rvmsudo gem install arel -v 2.0.10 --no-ri --no-RDoc
rvmsudo gem install atomic -v 1.1.10 --no-ri --no-RDoc
rvmsudo gem install builder -v 2.1.2 --no-ri --no-RDoc
rvmsudo gem install bundler -v 1.11.2 --no-ri --no-RDoc
rvmsudo gem install bundler-unload -v 1.0.2 --no-ri --no-RDoc
rvmsudo gem install cgi_multipart_eof_fix -v 2.5.0 --no-ri --no-RDoc
rvmsudo gem install chronic -v 0.10.2 --no-ri --no-RDoc
rvmsudo gem install crash-watch -v 1.1.12 --no-ri --no-RDoc
rvmsudo gem install daemons -v 1.1.2 --no-ri --no-RDoc
rvmsudo gem install erubis -v 2.6.6 --no-ri --no-RDoc
rvmsudo gem install executable-hooks -v 1.3.2 --no-ri --no-RDoc
rvmsudo gem install fastthread -v 1.0.7 --no-ri --no-RDoc
rvmsudo gem install gem_plugin -v 0.2.3 --no-ri --no-RDoc
rvmsudo gem install geocoder -v 1.1.9 --no-ri --no-RDoc
rvmsudo gem install geoip -v 1.4.0 --no-ri --no-RDoc
rvmsudo gem install geokit -v 1.6.5 --no-ri --no-RDoc
rvmsudo gem install geokit-rails -v 1.1.4 --no-ri --no-RDoc
rvmsudo gem install httparty -v 0.11.0 --no-ri --no-RDoc
rvmsudo gem install gibbon -v 1.1.2 --no-ri --no-RDoc
rvmsudo gem install hpricot -v 0.8.6 --no-ri --no-RDoc
rvmsudo gem install i18n -v 0.6.11 --no-ri --no-RDoc
rvmsudo gem install json -v 1.8.3 --no-ri --no-RDoc
rvmsudo gem install mime-types -v 1.25.1 --no-ri --no-RDoc
rvmsudo gem install mini_magick -v 3.2 --no-ri --no-RDoc
rvmsudo gem install minitest -v 5.4.3 --no-ri --no-RDoc
rvmsudo gem install newrelic_rpm -v 3.12.1.298 --no-ri --no-RDoc
rvmsudo gem install paperclip -v 2.3.9 --no-ri --no-RDoc
rvmsudo gem install polyglot -v 0.3.5 --no-ri --no-RDoc
rvmsudo gem install rdoc -v 4.2.2 --no-ri --no-RDoc
rvmsudo gem install rdoc -v 3.12 --no-ri --no-RDoc
rvmsudo gem install riddle -v 1.5.3 --no-ri --no-RDoc
rvmsudo gem install rubygems-bundler -v 1.4.4 --no-ri --no-RDoc
rvmsudo gem install sqlite3 -v 1.3.10 --no-ri --no-RDoc
rvmsudo gem install thinking-sphinx -v 1.4.12 --no-ri --no-RDoc
rvmsudo gem install thor -v 0.14.6 --no-ri --no-RDoc
rvmsudo gem install thread_safe -v 0.3.4 --no-ri --no-RDoc
rvmsudo gem install treetop -v 1.4.15 --no-ri --no-RDoc
rvmsudo gem install tzinfo -v 0.3.45 --no-ri --no-RDoc
rvmsudo gem install whenever -v 0.9.4 --no-ri --no-RDoc
rvmsudo gem install rdoc-data -v 4.1.0 --no-ri --no-RDoc
rvmsudo gem install rest-client -v 1.6.9 --no-ri --no-RDoc

# apache
apt-get -y install apache2

# passenger
rvmsudo gem install passenger -v 4.0.53 --no-ri --no-RDoc

apt-get -y install libcurl4-openssl-dev
apt-get -y install apache2-threaded-dev

yes | rvmsudo passenger-install-apache2-module

# sphinx
apt-get -y install sphinxsearch

# imagemagick
apt-get -y install imagemagick

# mysql gem
rvmsudo gem install mysql -v 2.8.1 --no-ri --no-RDoc

# configs
ln -fs /vagrant /var/www/site
cp -f /vagrant/config/compreingressos.conf /etc/apache2/sites-enabled/compreingressos.conf
cp -f /vagrant/config/passenger.conf /etc/apache2/mods-enabled/passenger.conf

service apache2 restart

touch /vagrant/tmp/restart.txt