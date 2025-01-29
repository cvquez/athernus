# == Schema Information
#
# Table name: living_place_attrs
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  living_place_id :bigint           not null
#  attractive_id   :bigint           not null
#
require "test_helper"

class LivingPlaceAttrTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
