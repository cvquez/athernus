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
require "test_helper"

class BusinessDimensionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
