json.extract! questionnaire, :id, :questionnaire_type_id, :name, :slug, :status, :created_at, :updated_at
json.url questionnaire_url(questionnaire, format: :json)
