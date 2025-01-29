class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :warning, :success
  before_action :set_global_variables
  before_action :check_maintenance

  protected

  def authorize_admin!
    return if helpers.authorized(controller_name, action_name)

    raise ActionController::RoutingError, 'Unauthorized'
  end

  private

  def check_maintenance
    return if admin_signed_in?
    return if %w[admins/sessions admin maintenance].include?(controller_path) || request.path.starts_with?('/admin/')
    return unless Setting.maintenance

    render template: 'admin/maintenance', status: :ok
  end

  def set_global_variables

  end
end
