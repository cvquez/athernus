# == Schema Information
#
# Table name: admins
#
#  id                     :bigint           not null, primary key
#  active                 :boolean          default(TRUE)
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  first_name             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unlock_token           :string
#  username               :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role_id                :bigint           not null
#
# Indexes
#
#  index_admins_on_email                 (email) UNIQUE
#  index_admins_on_reset_password_token  (reset_password_token) UNIQUE
#  index_admins_on_role_id               (role_id)
#  index_admins_on_username              (username) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
class Admin < ApplicationRecord
  devise :database_authenticatable, :timeoutable, :rememberable,
         :validatable, :trackable, timeout_in: 30.minutes
  paginates_per 10
  ransack_alias :search, :username_or_email_or_first_name_or_lastname

  belongs_to :role
  has_one_attached :image

  validates :role_id, presence: true
  validate :password_complexity
  def name
    "#{first_name} #{last_name}"
  end
  def permissions
    role.permissions.where('role_permissions.allowed')
  end

  def active_for_authentication?
    super && active
  end

  private

  def password_required?
    new_record? ? super : false
  end

  def password_complexity
    return if password.blank?
    return if password.match(/^(?=.*[a-z])(?=.*[A-Z])/)

    errors.add :password, 'La contraseña es insegura (se debe utilizar combinación de mayúsculas y minúsculas)'
  end

end

