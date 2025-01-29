# frozen_string_literal: true

# RequestLogsController
class RequestLogsController < ApplicationController
  before_action :set_request_log, only: %i[show edit update destroy]
  before_action :authenticate_admin!
  before_action :authorize_admin!
  layout 'admin'

  # GET /request_logs
  def index
    @search = RequestLog.all.ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @request_logs = @search.result(distinct: true).page(params[:page]).per(params[:length])
  end

  # GET /request_logs/1
  def show; end

  # GET /request_logs/new
  def new
    @request_log = RequestLog.new
  end

  # GET /request_logs/1/edit
  def edit; end

  # POST /request_logs
  def create
    @request_log = RequestLog.new(request_log_params)

    respond_to do |format|
      if @request_log.save
        format.html { redirect_to request_logs_url, notice: I18n.t('app.messages.created') }
        format.json { render :show, status: :created, location: @request_log }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /request_logs/1
  def update
    respond_to do |format|
      if @request_log.update(request_log_params)
        format.html { redirect_to request_logs_url, notice: I18n.t('app.messages.updated') }
        format.json { render :show, status: :ok, location: @request_log }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /request_logs/1
  def destroy
    @request_log.destroy
    respond_to do |format|
      format.html { redirect_to request_logs_url, notice: I18n.t('app.messages.destroyed') }
      format.json { head :no_content }
    end
  rescue ActiveRecord::InvalidForeignKey
    flash[:error] = I18n.t('app.messages.conflict')
    redirect_to request_logs_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_request_log
    @request_log = RequestLog.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def request_log_params
    params.require(:request_log).permit(:url, :method, :request_body, :response_body, :response_code, :content_type, :content_length, :started_at, :ended_at, :initiator, :response_headers)
  end
end
