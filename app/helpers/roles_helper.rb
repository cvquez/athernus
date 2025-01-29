module RolesHelper
  PermStruct = Struct.new(:id, :controller, :action, :pk, :allowed)
  def role_permissions(role)
    perms = Permission.where.not(deleted: true)
                      .order(controller: :asc, action: :asc)
                      .pluck(:id, :controller, :action)

    role_perms = []
    role_perms = role.permissions.pluck(:id, :permission_id, :allowed) if role

    perms.each_with_object({}) do |(id, controller, action), hash|
      hash[controller] ||= []
      perm_id, _, allowed = role_perms.find { |_, permission_id, _| permission_id == id }
      hash[controller] << PermStruct.new(id, controller, action, perm_id, allowed)
    end
  end
end
