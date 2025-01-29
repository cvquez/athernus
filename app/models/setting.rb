# == Schema Information
#
# Table name: settings
#
#  id          :bigint           not null, primary key
#  descripcion :text
#  telefono1   :string
#  telefono2   :string
#  value       :text
#  var         :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_settings_on_var  (var) UNIQUE
#
class Setting < RailsSettings::Base
  cache_prefix { 'v1' }

  scope :application do
    field :app_name, default: 'App name', readonly: false, validates: { presence: true, length: { in: 2..20 } }
    field :app_logo, default: '/logo.png', validates: { presence: true }
    field :facebook, default: 'https://facebook.com', validates: { presence: true }
    field :twitter, default: 'https://twitter.com', validates: { presence: true }
    field :instagram, default: 'https://instagram.com', validates: { presence: true }
    field :linkedin, default: 'https://linkedin.com', validates: { presence: true }
    field :contact_phone, default: '+595 981 123 456', validates: { presence: true }
    field :telefono1, default: '+595 981 123 456', validates: { presence: true }
    field :telefono2, default: '+595 981 123 456', validates: { presence: true }
    field :descripcion,
          default: 'Lorem ipsum dolor sit amet consectetur, adipisicing elit.',
          validates: { presence: true }
    field :maintenance, type: :boolean, default: false

    with_options if: -> { %w[telefono1 telefono2].include?(var) } do |on_condition|
      on_condition.validates_with WhatsappPhoneValidator
    end
  end

end
