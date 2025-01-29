# frozen_string_literal: true

# == Schema Information
#
# Table name: answers
#
#  id          :bigint           not null, primary key
#  value       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null
#  response_id :bigint           not null
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#  index_answers_on_response_id  (response_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (response_id => responses.id)
#
class Answer < ApplicationRecord
  ransack_alias :search, :name # <-- Add or edit searchable fields
  paginates_per 10
  belongs_to :response
  belongs_to :question
  validates :value, :question, presence: true
end
