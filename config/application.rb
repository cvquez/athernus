require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GDBase
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.time_zone = 'America/Asuncion'
    config.i18n.available_locales = %i[es po]
    config.i18n.default_locale = :es
    config.i18n.fallbacks = true
    config.exceptions_app = routes
    config.active_record.schema_format = :sql

    config.permissions = config_for(:permissions)

    config.active_storage.web_image_content_types << 'image/webp'
    config.active_storage.web_image_content_types << 'image/heif'
    # config.active_storage.variable_content_types << 'image/heif'

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.site_name = 'ATHERNUS'
    config.title_site_name_separator = '|'

    # Mail settings
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true # false: Don't care if the mailer can't send.
    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
    config.action_mailer.delivery_method = ENV.fetch('RAILS_MAIL_DELIVERY_METHOD', :smtp).to_sym
    config.action_mailer.perform_caching = false
    config.action_mailer.smtp_settings = {
      port: ENV.fetch('SMTP_PORT', 587).to_i,
      address: ENV.fetch('SMTP_ADDRESS', ''),
      user_name: ENV.fetch('SMTP_USERNAME', ''),
      password: ENV.fetch('SMTP_PASSWORD', ''),
      authentication: ENV.fetch('SMTP_AUTHENTICATION', :plain).to_sym, # :plain, :login or :cram_md5
      enable_starttls_auto: ENV.fetch('ENABLE_STARTTLS_AUTO', true)
    }

    # Active storage
    config.active_storage.replace_on_assign_to_many = false

    config.active_job.queue_adapter = :async # sidekiq
  end
end
