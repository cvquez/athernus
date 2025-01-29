json.extract! response, :id, :questionnaire_id, :person_id, :created_at, :updated_at
json.url response_url(response, format: :json)
