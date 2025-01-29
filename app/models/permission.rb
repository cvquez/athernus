# == Schema Information
#
# Table name: permissions
#
#  id         :bigint           not null, primary key
#  action     :string           default("")
#  controller :string           not null
#  deleted    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_permissions_on_controller_and_action  (controller,action) UNIQUE
#
class Permission < ApplicationRecord
  paginates_per 10
  ransack_alias :searchable_content, :controller_or_action
  validates :controller, :action, presence: true
  validates :action, uniqueness: { scope: :controller }
  # validate :valid_action
  has_many :role_permissions
  has_many :roles, through: :role_permissions

  private

  # def valid_action
  #   # Check if the controller exists
  #   unless ActionController::Base.subclasses.map(&:controller_name).include?(self.controller)
  #     errors.add(:controller, "El recurso no existe!")
  #     return
  #   end
  #
  #   # Check if the action exists in the controller
  #   controller_class = "#{self.controller}Controller".constantize
  #   unless controller_class.action_methods.include?(self.action)
  #     errors.add(:action, "No existe una acción llamada '#{self.action}' en el recurso")
  #   end
  # end
end
