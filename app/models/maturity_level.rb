# frozen_string_literal: true

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
class MaturityLevel < ApplicationRecord
  ransack_alias :search, :name_or_description # <-- Add or edit searchable fields
  paginates_per 10
  belongs_to :questionnaire_type

  validates :name, :description, :questionnaire_type, :min, :max, presence: true
  validates :min, numericality: { less_than: :max }
end
