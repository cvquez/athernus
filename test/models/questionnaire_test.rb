# == Schema Information
#
# Table name: questionnaires
#
#  id                    :bigint           not null, primary key
#  name                  :string
#  show_in_homepage      :boolean          default(FALSE)
#  slug                  :string
#  status                :boolean
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  questionnaire_type_id :bigint           not null
#
# Indexes
#
#  index_questionnaires_on_questionnaire_type_id  (questionnaire_type_id)
#  index_questionnaires_on_show_in_homepage       (show_in_homepage)
#  index_questionnaires_on_slug                   (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (questionnaire_type_id => questionnaire_types.id)
#
require "test_helper"

class QuestionnaireTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
