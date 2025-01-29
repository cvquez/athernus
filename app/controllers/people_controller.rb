# frozen_string_literal: true

# PeopleController
class PeopleController < ApplicationController
  before_action :set_person, only: %i[show edit update destroy]
  before_action :authenticate_admin!
  before_action :authorize_admin!
  layout 'admin'

  # GET /people
  def index
    @search = Person.all.ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @people = @search.result(distinct: true).page(params[:page]).per(params[:length])
    respond_to do |format|
      format.html
      format.csv do
        send_data CsvGeneratorService.(Person.all, headers: true), filename: "People.csv", type: 'text/csv'
      end
    end
  end

  # GET /people/1
  def show; end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit; end

  # POST /people
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to people_url, notice: I18n.t('app.messages.created') }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to people_url, notice: I18n.t('app.messages.updated') }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: I18n.t('app.messages.destroyed') }
      format.json { head :no_content }
    end
  rescue ActiveRecord::InvalidForeignKey
    flash[:error] = I18n.t('app.messages.conflict')
    redirect_to people_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def person_params
    params.require(:person).permit(:name, :email)
  end
end
