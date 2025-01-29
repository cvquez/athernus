# frozen_string_literal: true

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
class QuestionnaireType < ApplicationRecord
  ransack_alias :search, :name # <-- Add or edit searchable fields
  paginates_per 10

  has_many :questions
  has_many :questionnaires
  has_many :maturity_levels

  accepts_nested_attributes_for :maturity_levels, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
  def calculate_maturity_level(average)
    maturity_levels.where('min <= ? AND max >= ?', average, average).first
  end
end
