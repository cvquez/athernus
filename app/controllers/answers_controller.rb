# frozen_string_literal: true

# AnswersController
class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show edit update destroy]
  before_action :authenticate_admin!
  before_action :authorize_admin!
  layout 'admin'

  # GET /answers
  def index
    @search = Answer.all.ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @answers = @search.result(distinct: true).page(params[:page]).per(params[:length])
    respond_to do |format|
      format.html
      format.csv do
        send_data CsvGeneratorService.(Answer.all, headers: true), filename: "Answers.csv", type: 'text/csv'
      end
    end
  end

  # GET /answers/1
  def show; end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit; end

  # POST /answers
  def create
    @answer = Answer.new(answer_params)

    respond_to do |format|
      if @answer.save
        format.html { redirect_to answers_url, notice: I18n.t('app.messages.created') }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to answers_url, notice: I18n.t('app.messages.updated') }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: I18n.t('app.messages.destroyed') }
      format.json { head :no_content }
    end
  rescue ActiveRecord::InvalidForeignKey
    flash[:error] = I18n.t('app.messages.conflict')
    redirect_to answers_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def answer_params
    params.require(:answer).permit(:value, :response_id, :question_id)
  end
end
