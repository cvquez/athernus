# frozen_string_literal: true

# DimensionsController
class DimensionsController < ApplicationController
  before_action :set_dimension, only: %i[show edit update destroy]
  before_action :authenticate_admin!
  before_action :authorize_admin!
  layout 'admin'

  # GET /dimensions
  def index
    @search = Dimension.all.ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @dimensions = @search.result(distinct: true).page(params[:page]).per(params[:length])
    respond_to do |format|
      format.html
      format.csv do
        send_data CsvGeneratorService.call(Dimension.all, headers: true), filename: 'Dimensions.csv', type: 'text/csv'
      end
    end
  end

  # GET /dimensions/1
  def show; end

  # GET /dimensions/new
  def new
    @dimension = Dimension.new
  end

  # GET /dimensions/1/edit
  def edit; end

  # POST /dimensions
  def create
    @dimension = Dimension.new(dimension_params)

    respond_to do |format|
      if @dimension.save
        format.html { redirect_to dimensions_url, notice: I18n.t('app.messages.created') }
        format.json { render :show, status: :created, location: @dimension }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dimension.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dimensions/1
  def update
    respond_to do |format|
      if @dimension.update(dimension_params)
        format.html { redirect_to dimensions_url, notice: I18n.t('app.messages.updated') }
        format.json { render :show, status: :ok, location: @dimension }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dimension.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dimensions/1
  def destroy
    @dimension.destroy
    respond_to do |format|
      format.html { redirect_to dimensions_url, notice: I18n.t('app.messages.destroyed') }
      format.json { head :no_content }
    end
  rescue ActiveRecord::InvalidForeignKey
    flash[:error] = I18n.t('app.messages.conflict')
    redirect_to dimensions_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dimension
    @dimension = Dimension.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def dimension_params
    params.require(:dimension).permit(:name, :color)
  end
end
