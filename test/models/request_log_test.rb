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
require "test_helper"

class RequestLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
