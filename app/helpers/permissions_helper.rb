module PermissionsHelper

  def admin_permissions
    @admin_permissions ||= current_admin.permissions.distinct.to_a
  end

  def authorized(resource, action)
    resource = Array(resource)
    action = map_action(action)
    !admin_permissions.find { |perm| resource.include?(perm.controller) && perm.action == action }.nil?
  end

  def authorized?(resource, action)
    resource = Array(resource)
    action = map_action(action)
    !admin_permissions.find { |perm| resource.include?(perm.controller) && perm.action == action }.nil?
  end

  def authorize_admin!
    return if authorized?(controller_name, action_name)

    redirect_to admin_index_path, alert: I18n.t('errors.messages.unauthorized', default: 'You are not authorized to access this page.')
    # raise Exceptions::UnauthorizedError, I18n.t('errors.messages.unauthorized', default: 'You are not authorized to access this page.')
  end

  def map_action(action)
    Rails.configuration.permissions[:actions].each { |key, array| return key.to_s if array.include?(action) }
    action.to_s
  end

  def controllers_from_routes
    @controllers_from_routes ||= fetch_routes
  end

  private

  def fetch_routes
    Rails.application.routes.routes.each_with_object({}) do |route, result|
      controller = route.defaults[:controller]
      action = route.defaults[:action]
      next unless controller && action && !exclude?(controller)

      result[controller] ||= Set.new # Use Set for unique values and O(1) inclusion checks
      result[controller] << map_action(action)
    end.transform_values(&:sort).sort.to_h
  end

  def exclude?(controller)
    path = controller.is_a?(Class) ? controller.controller_path : controller
    patterns = Rails.configuration.permissions[:controllers][:exclude] || []
    patterns.any? { |pattern| path =~ wildcard_to_regex(pattern) }
  end

  def wildcard_to_regex(pattern)
    regex_str = pattern.gsub(%r{[-\[\]/\{\}()+?.\\\^$|]}, '\\\\\&').gsub('*', '.*')
    Regexp.new("^#{regex_str}$")
  end
end
