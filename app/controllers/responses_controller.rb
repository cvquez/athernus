# frozen_string_literal: true

# ResponsesController
class ResponsesController < ApplicationController
  before_action :set_response, only: %i[show edit update destroy]
  before_action :authenticate_admin!
  before_action :authorize_admin!
  layout 'admin'

  # GET /responses
  def index
    @search = Response.all.ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @responses = @search.result(distinct: true).page(params[:page]).per(params[:length])
    respond_to do |format|
      format.html
      format.csv do
        send_data CsvGeneratorService.(Response.all, headers: true), filename: "Responses.csv", type: 'text/csv'
      end
    end
  end

  # GET /responses/1
  def show; end

  # GET /responses/new
  def new
    @response = Response.new
  end

  # GET /responses/1/edit
  def edit; end

  # POST /responses
  def create
    @response = Response.new(response_params)

    respond_to do |format|
      if @response.save
        format.html { redirect_to responses_url, notice: I18n.t('app.messages.created') }
        format.json { render :show, status: :created, location: @response }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /responses/1
  def update
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to responses_url, notice: I18n.t('app.messages.updated') }
        format.json { render :show, status: :ok, location: @response }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1
  def destroy
    @response.destroy
    respond_to do |format|
      format.html { redirect_to responses_url, notice: I18n.t('app.messages.destroyed') }
      format.json { head :no_content }
    end
  rescue ActiveRecord::InvalidForeignKey
    flash[:error] = I18n.t('app.messages.conflict')
    redirect_to responses_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_response
    @response = Response.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def response_params
    params.require(:response).permit(:questionnaire_id, :person_id)
  end
end
