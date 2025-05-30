# frozen_string_literal: true

# Provides a set of configurations for filtering ransackable attributes, associations, and scopes.
# By default, it permits searching by `id`, `name`, `updated_at`, and `created_at`.
module RansackableAttributes
  extend ActiveSupport::Concern
  included do
    class_attribute :whitelisted_ransackable_associations
    class_attribute :whitelisted_ransackable_attributes
    class_attribute :whitelisted_ransackable_scopes

    class_attribute :default_ransackable_attributes
    self.default_ransackable_attributes = %w[id search name updated_at created_at position]

    def self.ransackable_associations(*_args)
      whitelisted_ransackable_associations || []
    end

    def self.ransackable_attributes(*_args)
      default_ransackable_attributes | (whitelisted_ransackable_attributes || [])
    end

    def self.ransackable_scopes(*_args)
      whitelisted_ransackable_scopes || []
    end
  end
end
