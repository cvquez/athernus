# config valid for current version and patch releases of Capistrano
# lock "~> 3.17.3"

set :application, 'simplev2'
set :repo_url, 'git@github.com:cvquez/simplev2.git'

# setup rbenv.
set :rbenv_type, :system
set :rbenv_ruby, '3.0.1'
set :rbenv_path, '/home/deploy/.rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails]

set :nvm_type, :user # or :system, depends on your nvm setup
set :nvm_node, 'v14.21.3'
set :nvm_prefix, "source #{fetch(:nvm_path)}/nvm.sh; "
set :nvm_map_bins, %w[node yarn rake gem bundle rails]

# set :default_env, { 'PASSENGER_INSTANCE_REGISTRY_DIR' => '/home/deploy/passenger_tmp' }
set :passenger_environment_variables, {
  'PASSENGER_INSTANCE_REGISTRY_DIR' => '/home/deploy/passenger_tmp',
  :path => '/home/deploy/.rbenv/versions/3.0.1/lib/ruby/gems/3.0.0/gems/passenger-6.0.15/bin:$PATH', rbenv_version: '3.0.0'
}
set :passenger_restart_command, '/home/deploy/.rbenv/versions/3.0.1/lib/ruby/gems/3.0.0/gems/passenger-6.0.15/bin/passenger-config restart-app'

# how many old releases do we want to keep, not much
set :keep_releases, 5

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push(
  'storage', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads'
)

# set :default_env, { path: "/home/rails/.nvm/versions/node/v14.21.3/bin" }

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
