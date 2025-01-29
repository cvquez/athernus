# == Schema Information
#
# Table name: maturity_levels
#
#  id                    :bigint           not null, primary key
#  color                 :string           default("#ffffff")
#  description           :text
#  max                   :integer          default(75)
#  min                   :integer          default(15)
#  name                  :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  questionnaire_type_id :bigint           not null
#
# Indexes
#
#  index_maturity_levels_on_questionnaire_type_id  (questionnaire_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (questionnaire_type_id => questionnaire_types.id)
#
require "test_helper"

class MaturityLevelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
