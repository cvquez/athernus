# frozen_string_literal: true

# == Schema Information
#
# Table name: questionnaires
#
#  id                    :bigint           not null, primary key
#  name                  :string
#  slug                  :string
#  status                :boolean
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  questionnaire_type_id :bigint           not null
#
# Indexes
#
#  index_questionnaires_on_questionnaire_type_id  (questionnaire_type_id)
#  index_questionnaires_on_slug                   (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (questionnaire_type_id => questionnaire_types.id)
#
class Questionnaire < ApplicationRecord
  ransack_alias :search, :name # <-- Add or edit searchable fields
  paginates_per 10
  belongs_to :questionnaire_type

  has_many :responses, dependent: :destroy

  validates :name, presence: true
  validates :slug, uniqueness: true
  before_create :generate_unique_slug

  private

  def generate_unique_slug
    if slug.blank?
      self.slug = loop do
        # Generate a completely random slug
        random_slug = SecureRandom.hex(10)
        break random_slug unless self.class.exists?(slug: random_slug)
      end
    end
  end
end
