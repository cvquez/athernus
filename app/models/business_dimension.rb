# frozen_string_literal: true

# == Schema Information
#
# Table name: business_dimensions
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_business_dimensions_on_name  (name) UNIQUE
#
class BusinessDimension < ApplicationRecord
  ransack_alias :search, :name # <-- Add or edit searchable fields
  paginates_per 10

end
