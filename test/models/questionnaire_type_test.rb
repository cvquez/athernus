# == Schema Information
#
# Table name: questionnaire_types
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_questionnaire_types_on_name  (name) UNIQUE
#
require "test_helper"

class QuestionnaireTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
