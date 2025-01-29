# frozen_string_literal: true

# FocusAreasController
class FocusAreasController < ApplicationController
  before_action :set_focus_area, only: %i[show edit update destroy]
  before_action :authenticate_admin!
  before_action :authorize_admin!
  layout 'admin'

  # GET /focus_areas
  def index
    @search = FocusArea.all.ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @focus_areas = @search.result(distinct: true).page(params[:page]).per(params[:length])
    respond_to do |format|
      format.html
      format.csv do
        send_data CsvGeneratorService.(FocusArea.all, headers: true), filename: "Focus areas.csv", type: 'text/csv'
      end
    end
  end

  # GET /focus_areas/1
  def show; end

  # GET /focus_areas/new
  def new
    @focus_area = FocusArea.new
  end

  # GET /focus_areas/1/edit
  def edit; end

  # POST /focus_areas
  def create
    @focus_area = FocusArea.new(focus_area_params)

    respond_to do |format|
      if @focus_area.save
        format.html { redirect_to focus_areas_url, notice: I18n.t('app.messages.created') }
        format.json { render :show, status: :created, location: @focus_area }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @focus_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /focus_areas/1
  def update
    respond_to do |format|
      if @focus_area.update(focus_area_params)
        format.html { redirect_to focus_areas_url, notice: I18n.t('app.messages.updated') }
        format.json { render :show, status: :ok, location: @focus_area }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @focus_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /focus_areas/1
  def destroy
    @focus_area.destroy
    respond_to do |format|
      format.html { redirect_to focus_areas_url, notice: I18n.t('app.messages.destroyed') }
      format.json { head :no_content }
    end
  rescue ActiveRecord::InvalidForeignKey
    flash[:error] = I18n.t('app.messages.conflict')
    redirect_to focus_areas_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_focus_area
    @focus_area = FocusArea.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def focus_area_params
    params.require(:focus_area).permit(:name)
  end
end
