json.extract! request_log, :id, :url, :method, :request_body, :response_body, :response_code, :content_type, :content_length, :started_at, :ended_at, :initiator, :response_headers, :created_at, :updated_at
json.url request_log_url(request_log, format: :json)
