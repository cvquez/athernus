# frozen_string_literal: true

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
#  dimension_id          :bigint           not null
#  focus_area_id         :bigint           not null
#  questionnaire_type_id :bigint           not null
#
# Indexes
#
#  index_questions_on_business_dimension_id  (business_dimension_id)
#  index_questions_on_dimension_id           (dimension_id)
#  index_questions_on_focus_area_id          (focus_area_id)
#  index_questions_on_questionnaire_type_id  (questionnaire_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (business_dimension_id => business_dimensions.id)
#  fk_rails_...  (dimension_id => dimensions.id)
#  fk_rails_...  (focus_area_id => focus_areas.id)
#  fk_rails_...  (questionnaire_type_id => questionnaire_types.id)
#
class Question < ApplicationRecord
  ransack_alias :search, :name_or_content # <-- Add or edit searchable fields
  paginates_per 10
  belongs_to :questionnaire_type
  belongs_to :dimension
  belongs_to :focus_area
  belongs_to :business_dimension, optional: true
end
