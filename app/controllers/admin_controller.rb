class AdminController < ApplicationController
  before_action :authenticate_admin!
  before_action :authorize_admin!
  layout 'admin'

  def index; end
end


