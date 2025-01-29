# frozen_string_literal: true

# AdminsController
class AdminsController < ApplicationController
  before_action :set_admin, only: %i[show edit update destroy]
  before_action :authenticate_admin!
  before_action :authorize_admin!
  layout 'admin'

  # GET /admins
  def index
    @search = Admin.all.ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @admins = @search.result(distinct: true).page(params[:page]).per(params[:length])
  end

  # GET /admins/1
  def show; end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit; end

  # POST /admins
  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to admins_url, notice: I18n.t('app.messages.created') }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to admins_url, notice: I18n.t('app.messages.updated') }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: I18n.t('app.messages.destroyed') }
      format.json { head :no_content }
    end
  rescue ActiveRecord::InvalidForeignKey
    flash[:error] = I18n.t('app.messages.conflict')
    redirect_to admins_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin
    @admin = Admin.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def admin_params
    params.require(:admin).permit(:username, :email, :password, :password_confirmation, :role_id, :active)
  end
end
