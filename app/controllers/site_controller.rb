class SiteController < ApplicationController
  def index
    @questionnaire = Questionnaire.find_by(show_in_homepage: true, status: true)
  end

  def new
    @questionnaire = Questionnaire.find_by(slug: params[:slug], status: true)
    if @questionnaire.nil?
      redirect_to root_path, alert: 'Cuestionario no encontrado'
      return
    end

    @response = Response.new
    @response.session = SecureRandom.uuid
    @response.build_person
    @questionnaire.questionnaire_type.questions.each do |question|
      @response.answers.build(question: question)
    end
  end

  def create
    @questionnaire = Questionnaire.find_by!(slug: params[:response][:questionnaire_slug])
    @response = Response.new(response_params)
    @response.questionnaire = @questionnaire

    if @response.save
      session[:response_id] = @response.id
      redirect_to thanks_path, notice: 'Gracias por completar el cuestionario'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def thanks
    @response = Response.find_by(id: session[:response_id])
    return redirect_to root_path unless @response

    answers = @response.answers.where.not(value: nil)
    Rails.logger.info "Respuestas encontradas: #{answers.count}"

    if answers.empty?
      redirect_to root_path, alert: 'No se encontraron respuestas'
      return
    end

    # Calcular resultados por dimensión
    dimension_scores = answers.joins(question: :dimension)
                              .group('dimensions.name')
                              .select('dimensions.name, CAST(SUM(answers.value) AS FLOAT) as total_score, COUNT(*) * 5 as max_possible')
                              .map do |result|
      score = ((result.total_score / result.max_possible) * 100).round(2)
      Rails.logger.info "Dimensión #{result.name}: #{result.total_score}/#{result.max_possible} = #{score}%"
      [result.name, score]
    end.to_h
    @dimension_results = dimension_scores
    Rails.logger.info "Porcentajes por dimensión: #{@dimension_results.inspect}"

    # Calcular resultados por dimensión
    begin
      dimension_scores = answers.joins(question: :business_dimension)
                                .where.not('business_dimensions.id' => nil)
                                .group('business_dimensions.name')
                                .select('business_dimensions.name, CAST(SUM(answers.value) AS FLOAT) as total_score, COUNT(*) * 5 as max_possible')
                                .map do |result|
        score = ((result.total_score / result.max_possible) * 100).round(2)
        Rails.logger.info "Dimensión #{result.name}: #{result.total_score}/#{result.max_possible} = #{score}%"
        [result.name, score]
      end.to_h
      @dimension_results = dimension_scores
      Rails.logger.info "Porcentajes por dimensión: #{@dimension_results.inspect}"
    rescue StandardError => e
      Rails.logger.error "Error al calcular dimensiones: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      @dimension_results = {}
    end

    # Calcular resultados por foco
    focus_scores = answers.joins(question: :focus_area)
                          .group('focus_areas.name')
                          .select('focus_areas.name, CAST(SUM(answers.value) AS FLOAT) as total_score, COUNT(*) * 5 as max_possible')
                          .map do |result|
      score = ((result.total_score / result.max_possible) * 100).round(2)
      Rails.logger.info "Foco #{result.name}: #{result.total_score}/#{result.max_possible} = #{score}%"
      [result.name, score]
    end.to_h
    @focus_results = focus_scores
    Rails.logger.info "Porcentajes por foco: #{@focus_results.inspect}"

    # Calcular promedio general
    total_score = answers.sum(:value).to_f
    total_possible = answers.count * 5
    @overall_score = ((total_score / total_possible) * 100).round(2)
    Rails.logger.info "Puntuación general: #{total_score}/#{total_possible} = #{@overall_score}%"
  end

  private

  def response_params
    params.require(:response).permit(
      :session,
      person_attributes: %i[name email],
      answers_attributes: %i[question_id value]
    )
  end
end
