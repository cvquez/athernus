# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Role < ApplicationRecord
  paginates_per 20
  ransack_alias :search, :name

  has_many :admins, dependent: :restrict_with_exception
  has_many :role_permissions, dependent: :restrict_with_exception
  has_many :permissions, through: :role_permissions
  validates :name, presence: true
  accepts_nested_attributes_for :role_permissions, allow_destroy: true
end
