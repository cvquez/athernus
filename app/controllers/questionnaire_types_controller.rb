# frozen_string_literal: true

# QuestionnaireTypesController
class QuestionnaireTypesController < ApplicationController
  before_action :set_questionnaire_type, only: %i[show edit update destroy]
  before_action :authenticate_admin!
  before_action :authorize_admin!
  layout 'admin'

  # GET /questionnaire_types
  def index
    @search = QuestionnaireType.all.ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @questionnaire_types = @search.result(distinct: true).page(params[:page]).per(params[:length])
    respond_to do |format|
      format.html
      format.csv do
        send_data CsvGeneratorService.call(QuestionnaireType.all, headers: true), filename: 'Questionnaire types.csv',
                                                                                  type: 'text/csv'
      end
    end
  end

  # GET /questionnaire_types/1
  def show; end

  # GET /questionnaire_types/new
  def new
    @questionnaire_type = QuestionnaireType.new
  end

  # GET /questionnaire_types/1/edit
  def edit; end

  # POST /questionnaire_types
  def create
    @questionnaire_type = QuestionnaireType.new(questionnaire_type_params)

    respond_to do |format|
      if @questionnaire_type.save
        format.html { redirect_to questionnaire_types_url, notice: I18n.t('app.messages.created') }
        format.json { render :show, status: :created, location: @questionnaire_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @questionnaire_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questionnaire_types/1
  def update
    respond_to do |format|
      if @questionnaire_type.update(questionnaire_type_params)
        format.html { redirect_to questionnaire_types_url, notice: I18n.t('app.messages.updated') }
        format.json { render :show, status: :ok, location: @questionnaire_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @questionnaire_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questionnaire_types/1
  def destroy
    @questionnaire_type.destroy
    respond_to do |format|
      format.html { redirect_to questionnaire_types_url, notice: I18n.t('app.messages.destroyed') }
      format.json { head :no_content }
    end
  rescue ActiveRecord::InvalidForeignKey
    flash[:error] = I18n.t('app.messages.conflict')
    redirect_to questionnaire_types_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_questionnaire_type
    @questionnaire_type = QuestionnaireType.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def questionnaire_type_params
    params.require(:questionnaire_type)
          .permit(:name,
                  maturity_levels_attributes: %i[id name description color min max _destroy],
                  questions_attributes: %i[id name content category_id focus_area_id business_dimension_id _destroy])
  end
end
