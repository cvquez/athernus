# frozen_string_literal: true

# == Schema Information
#
# Table name: request_logs
#
#  id               :bigint           not null, primary key
#  content_length   :integer          default(0)
#  content_type     :string
#  ended_at         :datetime
#  initiator        :integer          default(0)
#  method           :string
#  request_body     :text
#  response_body    :text
#  response_code    :integer
#  response_headers :text
#  started_at       :datetime
#  url              :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class RequestLog < ApplicationRecord
  ransack_alias :search, :url_or_method
  paginates_per 10

  before_save :filter_sensitive_data
  before_save :check_content_length

  def response_time
    ((ended_at - started_at) * 1000).round
  end

  def self.from_request(request, response, options = {})
    time = Time.zone.now
    create(
      url: request.uri.to_s,
      request_body: read_body(request.body),
      method: request.method,
      content_type: response.content_type,
      content_length: response.content_length || response.body.try(:length),
      started_at: options[:started_at] || time,
      ended_at: Time.zone.now,
      response_body: read_body(response.body),
      response_code: response.code
    )
  rescue StandardError => e
    Rails.logger.error(e)
  end

  private

  def filter_sensitive_data
    begin
      self.request_body = AdminUtils.filter_recursive(JSON.parse(request_body)).to_json
    rescue JSON::ParserError => e
      Rails.logger.error(e)
    end
    begin
      self.response_body = AdminUtils.filter_recursive(JSON.parse(response_body)).to_json
    rescue JSON::ParserError => e
      Rails.logger.error(e)
    end
  end

  def check_content_length
    self.response_body = response_body.truncate(1.megabyte) if response_body.length > 1.megabyte
    self.request_body = request_body.truncate(1.megabyte) if request_body.length > 1.megabyte
  end

  def self.read_body(body)
    body = body.respond_to?(:read) ? body.read : body
    body&.dup&.force_encoding('UTF-8')
  end

  private_class_method :read_body
end
