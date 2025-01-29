# frozen_string_literal: true

# BusinessDimensionsController
class BusinessDimensionsController < ApplicationController
  before_action :set_business_dimension, only: %i[show edit update destroy]
  before_action :authenticate_admin!
  before_action :authorize_admin!
  layout 'admin'

  # GET /business_dimensions
  def index
    @search = BusinessDimension.all.ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @business_dimensions = @search.result(distinct: true).page(params[:page]).per(params[:length])
    respond_to do |format|
      format.html
      format.csv do
        send_data CsvGeneratorService.(BusinessDimension.all, headers: true), filename: "Business dimensions.csv", type: 'text/csv'
      end
    end
  end

  # GET /business_dimensions/1
  def show; end

  # GET /business_dimensions/new
  def new
    @business_dimension = BusinessDimension.new
  end

  # GET /business_dimensions/1/edit
  def edit; end

  # POST /business_dimensions
  def create
    @business_dimension = BusinessDimension.new(business_dimension_params)

    respond_to do |format|
      if @business_dimension.save
        format.html { redirect_to business_dimensions_url, notice: I18n.t('app.messages.created') }
        format.json { render :show, status: :created, location: @business_dimension }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @business_dimension.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /business_dimensions/1
  def update
    respond_to do |format|
      if @business_dimension.update(business_dimension_params)
        format.html { redirect_to business_dimensions_url, notice: I18n.t('app.messages.updated') }
        format.json { render :show, status: :ok, location: @business_dimension }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @business_dimension.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /business_dimensions/1
  def destroy
    @business_dimension.destroy
    respond_to do |format|
      format.html { redirect_to business_dimensions_url, notice: I18n.t('app.messages.destroyed') }
      format.json { head :no_content }
    end
  rescue ActiveRecord::InvalidForeignKey
    flash[:error] = I18n.t('app.messages.conflict')
    redirect_to business_dimensions_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_business_dimension
    @business_dimension = BusinessDimension.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def business_dimension_params
    params.require(:business_dimension).permit(:name)
  end
end
