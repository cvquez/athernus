json.extract! question, :id, :name, :content, :questionnaire_type_id, :category_id, :focus_area_id, :business_dimension_id, :created_at, :updated_at
json.url question_url(question, format: :json)
