# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  ip_address       :string
#  session          :string
#  user_agent       :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  person_id        :bigint
#  questionnaire_id :bigint           not null
#
# Indexes
#
#  index_responses_on_person_id         (person_id)
#  index_responses_on_questionnaire_id  (questionnaire_id)
#
# Foreign Keys
#
#  fk_rails_...  (person_id => people.id)
#  fk_rails_...  (questionnaire_id => questionnaires.id)
#
require "test_helper"

class ResponseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
