questionnaire = %i[Individuo Equipos Empresa Liderazgo]
questionnaire.each do |f|
  QuestionnaireType.find_or_create_by name: f
  puts "#{f} done!"
end

maturity_levels = [
  { name: 'Inmaduro', description: 'El individuo muestra una comprensión y habilidad básicas en esta dimensión. Hay una necesidad significativa de desarrollo y aprendizaje.', min: 15, max: 27, color: '#FF0000', questionnaire_type_id: QuestionnaireType.find_by(name: 'Individuo').id }, { name: 'En Desarrollo', description: 'El individuo ha comenzado a desarrollar habilidades en esta dimensión pero todavía hay áreas de mejora. Es esencial proporcionar apoyo y formación adicional.', min: 28, max: 39, color: '#FFA500', questionnaire_type_id: QuestionnaireType.find_by(name: 'Individuo').id }, { name: 'Competente', description: 'El individuo muestra una competencia adecuada en esta dimensión. Puede manejar tareas y situaciones estándar con eficacia, pero puede necesitar apoyo en situaciones más complejas.', min: 40, max: 51, color: '#FFFF00', questionnaire_type_id: QuestionnaireType.find_by(name: 'Individuo').id }, { name: 'Avanzado', description: 'El individuo demuestra una comprensión y habilidad avanzadas en esta dimensión. Puede manejar situaciones complejas y desafiantes con eficacia y es visto como un recurso en esta área.', min: 52, max: 63, color: '#32CD32', questionnaire_type_id: QuestionnaireType.find_by(name: 'Individuo').id }, { name: 'Experto', description: 'El individuo es altamente competente y muestra maestría en esta dimensión. Es un líder en esta área, proporcionando guía y mentoría a otros.', min: 64, max: 75, color: '#006400', questionnaire_type_id: QuestionnaireType.find_by(name: 'Individuo').id },
  { name: 'Inicial', description: 'El equipo está en una etapa temprana de su desarrollo en esta dimensión. Puede haber falta de procesos, habilidades o cohesión. Es esencial identificar áreas de mejora y trabajar en ellas.', min: 15, max: 27, color: '#FF0000', questionnaire_type_id: QuestionnaireType.find_by(name: 'Equipos').id }, { name: 'En Desarrollo', description: 'El equipo ha comenzado a establecer algunas prácticas y tiene un entendimiento básico en esta dimensión, pero aún hay desafíos significativos que superar.', min: 28, max: 39, color: '#FFA500', questionnaire_type_id: QuestionnaireType.find_by(name: 'Equipos').id }, { name: 'Definido', description: 'El equipo tiene procesos y prácticas establecidos en esta dimensión y muestra consistencia en su desempeño. Sin embargo, todavía hay oportunidades para la mejora y la innovación.', min: 40, max: 51, color: '#FFFF00', questionnaire_type_id: QuestionnaireType.find_by(name: 'Equipos').id }, { name: 'Gestionado', description: 'El equipo está muy avanzado en esta dimensión, con procesos y prácticas bien gestionados. Se enfocan en la mejora continua y en adaptarse a cambios y desafíos.', min: 52, max: 63, color: '#32CD32', questionnaire_type_id: QuestionnaireType.find_by(name: 'Equipos').id }, { name: 'Optimizado', description: 'El equipo ha alcanzado la excelencia en esta dimensión. No solo tienen procesos y prácticas optimizadas, sino que también son líderes e innovadores, estableciendo estándares para otros equipos.', min: 64, max: 75, color: '#006400', questionnaire_type_id: QuestionnaireType.find_by(name: 'Equipos').id },
  { name: 'Inicial', description: 'La empresa está en una etapa inicial en esta dimensión. Hay una falta significativa de estructura, procesos y/o cultura en el área evaluada. Es esencial identificar y abordar las áreas de mejora para avanzar.', min: 15, max: 27, color: '#FF0000', questionnaire_type_id: QuestionnaireType.find_by(name: 'Empresa').id }, { name: 'En Desarrollo', description: 'La empresa ha comenzado a establecer algunas prácticas y procesos en esta dimensión, pero aún enfrenta desafíos significativos. Es necesario fortalecer y consolidar las iniciativas existentes y abordar las brechas identificadas.', min: 28, max: 39, color: '#FFA500', questionnaire_type_id: QuestionnaireType.find_by(name: 'Empresa').id }, { name: 'Definido', description: 'La empresa tiene prácticas y procesos definidos en esta dimensión y muestra un progreso constante. Sin embargo, aún hay oportunidades para la mejora y la optimización. Es importante continuar con el monitoreo y la adaptación.', min: 40, max: 51, color: '#FFFF00', questionnaire_type_id: QuestionnaireType.find_by(name: 'Empresa').id }, { name: 'Gestionado', description: 'La empresa gestiona eficazmente esta dimensión, con procesos y prácticas bien establecidos que son monitoreados y ajustados regularmente. Aunque está en buen camino, siempre hay espacio para la innovación y la mejora continua.', min: 52, max: 63, color: '#32CD32', questionnaire_type_id: QuestionnaireType.find_by(name: 'Empresa').id }, { name: 'Optimizado', description: 'La empresa muestra excelencia en esta dimensión. No solo tiene prácticas y procesos bien establecidos, sino que también se dedica a la mejora continua, la innovación y la adaptación proactiva a los cambios. Es un referente en el área evaluada.', min: 64, max: 75, color: '#006400', questionnaire_type_id: QuestionnaireType.find_by(name: 'Empresa').id },
  { name: 'Inicial', description: 'El líder muestra un entendimiento y habilidades básicas en esta dimensión. Es esencial reconocer las áreas de mejora y buscar capacitación o mentoría para desarrollar habilidades más sólidas.', min: 15, max: 27, color: '#FF0000', questionnaire_type_id: QuestionnaireType.find_by(name: 'Liderazgo').id }, { name: 'En Desarrollo', description: 'El líder ha comenzado a desarrollar habilidades en esta dimensión pero aún tiene áreas significativas de mejora. Es importante continuar con la formación y buscar oportunidades para practicar y mejorar.', min: 28, max: 39, color: '#FFA500', questionnaire_type_id: QuestionnaireType.find_by(name: 'Liderazgo').id }, { name: 'Competente', description: 'El líder muestra competencia en esta dimensión y es capaz de manejar situaciones comunes con eficacia. Sin embargo, aún hay espacio para el crecimiento y la mejora continua.', min: 40, max: 51, color: '#FFFF00', questionnaire_type_id: QuestionnaireType.find_by(name: 'Liderazgo').id }, { name: 'Avanzado', description: 'El líder demuestra habilidades avanzadas en esta dimensión y es capaz de manejar situaciones complejas con eficacia. Es esencial mantenerse actualizado y buscar oportunidades para seguir creciendo.', min: 52, max: 63, color: '#32CD32', questionnaire_type_id: QuestionnaireType.find_by(name: 'Liderazgo').id }, { name: 'Experto', description: 'El líder es un experto en esta dimensión, mostrando un alto nivel de maestría. Es un referente en esta área y puede servir como mentor o guía para otros.', min: 64, max: 75, color: '#006400', questionnaire_type_id: QuestionnaireType.find_by(name: 'Liderazgo').id }
]
maturity_levels.each do |m|
  MaturityLevel.find_or_create_by name: m[:name], questionnaire_type_id: m[:questionnaire_type_id] do |ml|
    ml.description = m[:description]
    ml.min = m[:min]
    ml.max = m[:max]
    ml.color = m[:color]
  end
  puts "#{m[:name]} done!"
end

dimensions = %i[Cuerpo Mente Alma]
dimensions.each do |d|
  Dimension.find_or_create_by name: d
  puts "#{d} done!"
end

focuses = %i[Personas Resultados]
focuses.each do |f|
  FocusArea.find_or_create_by name: f
  puts "#{f} done!"
end

business_dimensions = %i[Prácticas/Herramientas/Tecnología Estructura/Equipos Estrategia Producto/Servicio Personas Liderazgo
                         Cultura]
business_dimensions.each do |f|
  BusinessDimension.find_or_create_by name: f
  puts "#{f} done!"
end
