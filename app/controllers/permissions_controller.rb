class PermissionsController < ApplicationController
  before_action :authenticate_admin!
  before_action :authorize_admin!
  before_action :set_permission, only: %i[ show edit update destroy ]
  before_action :all_resources, only: %i[ new edit update create ]

  # GET /permissions or /permissions.json
  def index
    @search = Permission.where.not(deleted: true).ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @permissions = @search.result(distinct: true).page(params[:page]).per(params[:length])

    respond_to do |format|
      format.html { render layout: 'admin' }
      format.csv { send_data @permissions.to_csv, filename: "permissions-#{Date.today}.csv" }
    end
  end

  # GET /permissions/1 or /permissions/1.json
  def show
    render layout: "admin"
  end

  # GET /permissions/new
  def new
    @permission = Permission.new
    render layout: "admin"
  end

  # GET /permissions/1/edit
  def edit
    # @resources = get_all_resources
    render layout: "admin"
  end

  # POST /permissions or /permissions.json
  def create
    @permission = Permission.new(permission_params)

    respond_to do |format|
      if @permission.save
        format.html { redirect_to permissions_url, notice: "El registro se creó con éxito." }
        format.json { render :show, status: :created, location: @permission }
      else
        format.html { render :new, layout: 'admin', status: :unprocessable_entity }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /permissions/1 or /permissions/1.json
  def update
    respond_to do |format|
      if @permission.update(permission_params)
        format.html { redirect_to permissions_url, notice: "El registro se actualizó con éxito." }
        format.json { render :show, status: :ok, location: @permission }
      else
        format.html { render :edit, layout: 'admin', status: :unprocessable_entity }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permissions/1 or /permissions/1.json
  def destroy
    @permission.deleted = true
    @permission.save
    respond_to do |format|
      format.html { redirect_to permissions_url, notice: "El registro fue eliminado con éxito." }
      format.json { head :no_content }
    end
  end

  private

  def all_resources
    @all_resources ||= self.helpers.get_all_resources
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_permission
    @permission = Permission.find_by!(id: params[:id], deleted: false)
  end

  # Only allow a list of trusted parameters through.
  def permission_params
    params.require(:permission).permit(:controller, :action)
  end
end
