# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__ || '.')

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'bootsnap/setup' # Speed up boot time by caching expensive operations.

# Load the app's custom environment variables here, so that they are loaded before environments/*.rb
app_env_vars = File.expand_path('env.rb', __dir__ || '.')
load(app_env_vars) if File.exist?(app_env_vars)
