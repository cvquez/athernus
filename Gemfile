# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~>3.3.3'

gem 'rails', '~> 7.0.8'

# Sprockets is a Ruby library for compiling and serving web assets.
gem 'sprockets-rails', require: 'sprockets/railtie'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'cocoon'
gem 'devise'
gem 'jbuilder', '~> 2.7'
gem 'kaminari'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'

# assets
gem 'cssbundling-rails'
gem 'jsbundling-rails'

group :development do
  gem 'annotate'
  gem 'bullet' # Increase your application's performance by reducing the number of queries
  # gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'foreman'
  gem 'hirb', require: false
  gem 'letter_opener' # Preview email in the default browser instead of sending it
  gem 'rubocop'
  gem 'rubocop-rails', require: false
  gem 'web-console'

  # Capistrano deployment
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'
  # capistrano-passenger
  gem 'capistrano-passenger', '>= 0.1.1'
  gem 'capistrano-rails'
  gem 'capistrano-yarn'
  # capistrano-nvm202x
  gem 'capistrano-nvm202x', require: false
  # capistrano-faster-assets
  gem 'capistrano-faster-assets', '~> 1.0'
  gem 'ed25519', '>= 1.2', '< 2.0'
  # bcrypt_pbkdf
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
  # gem 'debase'
  # gem 'ruby-debug-ide'
  gem "faker", "~> 3.3"
end

group :development, :production do
  gem 'actionpack-page_caching'
  gem 'active_storage_drag_and_drop'
  gem 'active_storage_validations'
  gem 'acts_as_list'
  gem 'cairo' # dependency for output
  gem 'chunky_png'
  gem 'devise-encryptable'
  gem 'down', '~> 5.0'
  gem 'faraday'
  gem 'image_processing', '~> 1.2'
  gem 'listen', '~> 3.3'
  gem 'paperclip'
  gem 'ransack', '~> 4.1.0'
  gem 'recaptcha', '~> 5.12'
  gem 'simple_form'
  gem 'spring'
end

group :production do
  gem 'passenger', '~> 6.0.15'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'webdrivers'
end

gem 'inline_svg'
gem 'rails-settings-cached', '~> 2.9'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem "carrierwave", "~> 3.0"

gem "rails_real_favicon", "~> 0.1.1"

gem "rswag", "~> 2.13"

gem "prawn", "~> 2.4"

gem "prawn-table", "~> 0.2.2"
gem "prawn-icon", "~> 3.1"


gem "chartkick", "~> 5.0"
