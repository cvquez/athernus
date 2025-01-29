# == Schema Information
#
# Table name: questions
#
#  id                    :bigint           not null, primary key
#  content               :text
#  name                  :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  business_dimension_id :bigint
#  category_id           :bigint           not null
#  focus_area_id         :bigint           not null
#  questionnaire_type_id :bigint           not null
#
# Indexes
#
#  index_questions_on_business_dimension_id  (business_dimension_id)
#  index_questions_on_category_id            (category_id)
#  index_questions_on_focus_area_id          (focus_area_id)
#  index_questions_on_questionnaire_type_id  (questionnaire_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (business_dimension_id => business_dimensions.id)
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (focus_area_id => focus_areas.id)
#  fk_rails_...  (questionnaire_type_id => questionnaire_types.id)
#
require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
