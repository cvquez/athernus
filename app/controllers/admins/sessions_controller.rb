# frozen_string_literal: true

module Admins
  # Customizes user session management with specific sign-in parameters.
  class SessionsController < Devise::SessionsController
    layout 'login'

    before_action :configure_sign_in_params, only: [:create]

    def after_sign_out_path_for(resource)
      session_path(resource)
    end

    def after_sign_in_path_for(resource)
      stored_location_for(resource) || admin_index_path
    end

    protected

    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:login])
    end

    # GET /admins/sign_in
    # POST /admins/sign_in
    # DELETE /admins/sign_out
  end
end
