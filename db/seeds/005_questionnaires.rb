QuestionnaireType.all.each do |f|
  questionnaire = Questionnaire.find_or_create_by name: "Test de #{f.name}", questionnaire_type_id: f.id
  puts "#{f.name} done!"

  (1..1000).each do |i|
    r = Response.create questionnaire_id: questionnaire.id, session: SecureRandom.hex(10), ip_address: '', user_agent: ''
    questionnaire.questionnaire_type.questions.each do |q|
      r.answers.create question_id: q.id, value: rand(1..5)
    end
  end

end