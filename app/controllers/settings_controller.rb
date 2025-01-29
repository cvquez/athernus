class SettingsController < ApplicationController
  before_action :authenticate_admin!
  before_action :authorize_admin!
  layout 'admin'

  def create
    @errors = ActiveModel::Errors.new(self)
    setting_params.each_key do |key|
      next if setting_params[key].nil?

      setting = Setting.new(var: key)
      setting.value = setting_params[key].strip
      @errors.merge!(setting.errors) unless setting.valid?
    end
    if @errors.any?
      return render :index, status: :unprocessable_entity
    end

    setting_params.each_key do |key|
      Setting.send("#{key}=", setting_params[key].strip) unless setting_params[key].nil?
    end

    redirect_to settings_path, notice: I18n.t('app.messages.updated')
  end

  private

  def setting_params
    params.require(:setting).permit(
      :app_logo, :facebook, :instagram, :linkedin, :contact_phone, :descripcion, :telefono1, :telefono2,
      :maintenance, :app_name
    )
  end
end
