# frozen_string_literal: true

# QuestionnairesController
class QuestionnairesController < ApplicationController
  before_action :set_questionnaire, only: %i[show edit update destroy]
  before_action :authenticate_admin!
  before_action :authorize_admin!
  layout 'admin'

  # GET /questionnaires
  def index
    @search = Questionnaire.all.ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @questionnaires = @search.result(distinct: true).page(params[:page]).per(params[:length])
    respond_to do |format|
      format.html
      format.csv do
        send_data CsvGeneratorService.(Questionnaire.all, headers: true), filename: "Questionnaires.csv", type: 'text/csv'
      end
    end
  end

  # GET /questionnaires/1
  def show
    @questionnaire = Questionnaire.includes(:questionnaire_type => { :questions => :category }).find(params[:id])
    @category_data = {}
    @focus_data = {}
    @questionnaire.questionnaire_type.questions.each do |question|
      category = question.category
      q_average = Answer.where(question_id: question.id).average(:value).to_f.round(2)
      q_count = Answer.where(question_id: question.id).count
      @category_data[category.name] ||= { average: 0, answers: 0, color: category.color }
      @category_data[category.name][:average] += q_average
      @category_data[category.name][:answers] += q_count
      focus = question.focus_area
      @focus_data[focus.name] ||= { count: 0, sum: 0 }
      @focus_data[focus.name][:count] += 1
      @focus_data[focus.name][:sum] += q_average
    end
    @category_data.each do |category, data|
      maturity_level = @questionnaire.questionnaire_type.calculate_maturity_level(data[:average])
      data[:maturity_level] = maturity_level
    end
    @focus_data.each do |focus, data|
      data[:sum] = data[:sum].round(2)
      data[:total] = (data[:count] * 5)
      data[:percentage] = (data[:sum] * 100 / data[:total]).round(2)
    end
    @chart_data = @category_data.map { |category, data| [category, data[:average].round(2)] }.to_h
  end

  # GET /questionnaires/new
  def new
    @questionnaire = Questionnaire.new
    @questionnaire.send(:generate_unique_slug)
  end

  # GET /questionnaires/1/edit
  def edit; end

  # POST /questionnaires
  def create
    @questionnaire = Questionnaire.new(questionnaire_params)

    respond_to do |format|
      if @questionnaire.save
        format.html { redirect_to questionnaires_url, notice: I18n.t('app.messages.created') }
        format.json { render :show, status: :created, location: @questionnaire }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questionnaires/1
  def update
    respond_to do |format|
      if @questionnaire.update(questionnaire_params)
        format.html { redirect_to questionnaires_url, notice: I18n.t('app.messages.updated') }
        format.json { render :show, status: :ok, location: @questionnaire }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questionnaires/1
  def destroy
    @questionnaire.destroy
    respond_to do |format|
      format.html { redirect_to questionnaires_url, notice: I18n.t('app.messages.destroyed') }
      format.json { head :no_content }
    end
  rescue ActiveRecord::InvalidForeignKey
    flash[:error] = I18n.t('app.messages.conflict')
    redirect_to questionnaires_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def questionnaire_params
    params.require(:questionnaire).permit(:questionnaire_type_id, :name, :slug, :status)
  end
end
