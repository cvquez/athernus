# frozen_string_literal: true

# ApiClient
module ApiClient
  # noinspection RubyMismatchedArgumentType
  class << self

    def silent
      self.silent_logs = true
      self
    end

    def json
      self.http_options = { 'Content-Type' => 'application/json' }
    end

    def get(url, options = {})
      time = Time.zone.now
      options = init_headers.merge(options)
      data = options.delete(:data)
      uri = URI(url)
      http = Net::HTTP.start(
        uri.host, uri.port, use_ssl: uri.scheme == 'https', verify_mode: OpenSSL::SSL::VERIFY_NONE
      )
      request = Net::HTTP::Get.new(uri, options)
      request.body = data.to_json if data
      response = http&.request(request)
      RequestLog.from_request(request, response, started_at: time) unless silent_logs
      ApiResponse.new(response)
    end

    def post(url, data, options = {})
      time = Time.zone.now
      options = init_headers.merge(options)
      uri = URI(url)
      http = Net::HTTP.start(
        uri.host, uri.port, use_ssl: uri.scheme == 'https', verify_mode: OpenSSL::SSL::VERIFY_NONE
      )
      request = Net::HTTP::Post.new(uri, options)
      request.body = data.to_json
      response = http.request(request)
      RequestLog.from_request(request, response, started_at: time) unless silent_logs
      ApiResponse.new(response)
    end

    private

    attr_accessor :http_options, :silent_logs

    def init_headers
      { 'Content-Type' => 'application/json' }
    end

    def try_json(body)
      JSON.parse(body) if body.present?
    rescue JSON::ParserError
      body
    end

  end

  # class ApiResponse
  class ApiResponse
    attr_accessor :response

    def initialize(response)
      @response = response
    end

    def content_type
      response&.content_type
    end

    def body
      parse_body
    end

    def code
      response&.code.try(:to_i) || response&.code
    end

    def length
      response&.content_length || response&.body&.length
    end

    def inspect
      "ApiResponse(code: #{code}, content_type: '#{content_type}')"
    end

    private

    def parse_body
      response.try(:content_type) == 'application/json' ? JSON.parse(response.body) : response&.body
    rescue StandardError => e
      Rails.logger.error(e)
      response&.body
    end
  end
end
