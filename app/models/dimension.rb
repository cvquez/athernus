# frozen_string_literal: true

# == Schema Information
#
# Table name: dimensions
#
#  id         :bigint           not null, primary key
#  color      :string           default("#ffffff")
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_dimensions_on_name  (name) UNIQUE
#
class Dimension < ApplicationRecord
  ransack_alias :search, :name # <-- Add or edit searchable fields
  paginates_per 10
end
