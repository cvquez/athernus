# frozen_string_literal: true

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
class Questionnaire < ApplicationRecord
  ransack_alias :search, :name # <-- Add or edit searchable fields
  paginates_per 10
  belongs_to :questionnaire_type

  has_many :responses, dependent: :destroy

  validates :name, presence: true
  validates :slug, uniqueness: true
  before_create :generate_unique_slug
  before_save :ensure_only_one_homepage_questionnaire

  private

  def generate_unique_slug
    return if slug.present?

    self.slug = loop do
      # Generate a completely random slug
      random_slug = SecureRandom.hex(10)
      break random_slug unless self.class.exists?(slug: random_slug)
    end
  end

  def ensure_only_one_homepage_questionnaire
    return unless show_in_homepage_changed? && show_in_homepage

    Questionnaire.where.not(id: id).update_all(show_in_homepage: false)
  end
end
