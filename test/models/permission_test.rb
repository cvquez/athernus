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
require "test_helper"

class PermissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
