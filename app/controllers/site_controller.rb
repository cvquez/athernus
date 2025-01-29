class SiteController < ApplicationController
  def new
    @questionnaire = Questionnaire.find_by(slug: params[:slug], status: true)
    if @questionnaire
      @response = Response.new(questionnaire: @questionnaire)
      @response.build_person()
      @questionnaire.questionnaire_type.questions.each do |question|
        @response.answers.build(question: question)
      end
    else
      render :not_found
    end
  end

  def create
    @questionnaire = Questionnaire.find_by(slug: params[:response][:questionnaire_slug], status: true)
    if @questionnaire
      #noinspection RubyArgCount
      @response = Response.new(response_params.merge(
        questionnaire: @questionnaire,
        ip_address: request.remote_ip,
        session: session.id,
        user_agent: request.user_agent))
      if @response.save
        redirect_to thanks_path
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to :not_found
    end
  end

  def thanks
  end

  private

  def response_params
    params.require(:response).permit(
      person_attributes: [:name, :email],
      answers_attributes: [:value, :question_id]
    )
  end
end