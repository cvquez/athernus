## Crear el archivo config/database.yml

El proyecto no sincroniza el archivo de base de datos

```bash
nano config/database.yml
```

```yml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000
  username: postgres
  password: postgres
  host: localhost
  port: 5432

development:
  <<: *default
  database: database_dev

test:
  <<: *default
  database: database_test

production:
  <<: *default
  database: database_prod
```

### Cargar registro de permisos

```bash
rails db:seed file=001_permissions
```

### Migrar datos de faq a support_questions

```bash
rails db:seed FILE=* MIGRATE=faqs
rails db:seed FILE=* MIGRATE=faqs RAILS_ENV=production
```

### set tsvector weights

```bash
rails db:migrate:down VERSION=20230613133922 RAILS_ENV=production
rails db:migrate:down VERSION=20230622045349 RAILS_ENV=production
git pull
rails db:migrate RAILS_ENV=production
```

### Passenger standalone

```bash
bundle install --without development test
```


### config apache2

```apache
<VirtualHost *:80>
ServerName yourserver.com

    # Tell Apache and Passenger where your app's 'public' directory is
    DocumentRoot /path-to-your-app/public

    PassengerRuby /path-to-ruby

    # Relax Apache security settings
    <Directory /path-to-your-app/public>
      Allow from all
      Options -MultiViews
      # Uncomment this if you're on Apache > 2.4:
      #Require all granted
    </Directory>
</VirtualHost>
```

### Configuracion capistrano

```bash
sudo apt install -y apache2 postgresql postgresql-contrib git curl gnupg build-essential
sudo apt install -y libz-dev libcairo2-dev libcurl4-openssl-dev apache2-dev libapr1-dev libaprutil1-dev
sudo apt install libffi-dev libyaml-dev # libssl-dev libpq-dev postgresql-server-dev-all

sudo adduser deploy
sudo mkdir -p ~deploy/.ssh
touch $HOME/.ssh/authorized_keys
sudo sh -c "cat $HOME/.ssh/authorized_keys >> ~deploy/.ssh/authorized_keys"
sudo chown -R deploy: ~deploy/.ssh
sudo chmod 700 ~deploy/.ssh
sudo sh -c "chmod 600 ~deploy/.ssh/*"

sudo mkdir -p /var/www/project_name/shared
sudo chown deploy: /var/www/project_name /var/www/project_name/shared

sudo -u deploy -H bash -l

ssh-keygen -t ed25519 -C "gdigital.dev@hotmail.com"

mkdir -p /var/www/project_name/shared/config
nano /var/www/project_name/shared/config/database.yml &&
nano /var/www/project_name/shared/config/secrets.yml
```

```yml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: 5
  username: 'project_nameweb'

production:
  <<: *default
  database: project_nameweb
```   

bundle exec rake secret RAILS_ENV=production


cd /var/www/project_name/shared/
chmod 700 config
chmod 600 config/database.yml config/secrets.yml

curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.bashrc

nvm install 14 # version de nodejs


npm install -g yarn




git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc
source ~/.bashrc
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build


rbenv install 3.2.2 --verbose # Version de ruby

gem install bundler --no-rdoc --no-ri

gem install passenger -v 6.0.15





sudo su postgres
psql

create database project_nameweb;
CREATE USER project_nameweb WITH PASSWORD 'project_nameweb';
ALTER DATABASE project_nameweb OWNER TO project_nameweb;








LoadModule passenger_module /home/deploy/.rbenv/versions/3.0.1/lib/ruby>
<IfModule mod_passenger.c>
PassengerRoot /home/deploy/.rbenv/versions/3.0.1/lib/ruby/gems/3.0>     PassengerDefaultRuby /home/deploy/.rbenv/versions/3.0.1/bin/ruby
PassengerInstanceRegistryDir /home/deploy/passenger_tmp
</IfModule>




EDITOR=nano bin/rails credentials:edit



cap production deploy


## Notas deploy

Para ubicar el proyecto en el root eliminar la siguiente linea del archivo config/environments/production.rb

```
  config.relative_url_root = '/new'
```