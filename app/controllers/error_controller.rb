class ErrorController < ApplicationController
  def not_found; end

  def unprocessable_entity; end

  def internal_server_error; end
end
