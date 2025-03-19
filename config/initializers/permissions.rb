# frozen_string_literal: true

# Configuración de permisos para la aplicación
Rails.application.config.permissions = {
  controllers: {
    exclude: [
      'action_mailbox/*',
      'active_storage/*',
      'admins/sessions',
      'users/sessions',
      'users/registrations',
      'users/passwords',
      'rails/*',
      'turbo/*',
      'devise/*',
      'site',
      'error',
      'errors',
      'dashboard'
    ]
  },
  actions: {
    create: %w[new create copy],
    read: %w[show index download report],
    update: %w[edit update save draft publish sort],
    delete: %w[destroy destroy_image]
  }
}
