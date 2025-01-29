# == Schema Information
#
# Table name: athernus
#
#  id               :bigint           not null, primary key
#  name             :string
#  slug             :string
#  status           :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  questionnaire_id :bigint           not null
#
# Indexes
#
#  index_athernus_on_questionnaire_id  (questionnaire_id)
#
# Foreign Keys
#
#  fk_rails_...  (questionnaire_id => questionnaires.id)
#
require "test_helper"

class AthernuTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
