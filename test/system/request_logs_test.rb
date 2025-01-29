require "application_system_test_case"

class RequestLogsTest < ApplicationSystemTestCase
  setup do
    @request_log = request_logs(:one)
  end

  test "visiting the index" do
    visit request_logs_url
    assert_selector "h1", text: "Request logs"
  end

  test "should create request log" do
    visit request_logs_url
    click_on "New request log"

    fill_in "Content length", with: @request_log.content_length
    fill_in "Content type", with: @request_log.content_type
    fill_in "Ended at", with: @request_log.ended_at
    fill_in "Initiator", with: @request_log.initiator
    fill_in "Method", with: @request_log.method
    fill_in "Request body", with: @request_log.request_body
    fill_in "Response body", with: @request_log.response_body
    fill_in "Response code", with: @request_log.response_code
    fill_in "Response headers", with: @request_log.response_headers
    fill_in "Started at", with: @request_log.started_at
    fill_in "Url", with: @request_log.url
    click_on "Create Request log"

    assert_text "Request log was successfully created"
    click_on "Back"
  end

  test "should update Request log" do
    visit request_log_url(@request_log)
    click_on "Edit this request log", match: :first

    fill_in "Content length", with: @request_log.content_length
    fill_in "Content type", with: @request_log.content_type
    fill_in "Ended at", with: @request_log.ended_at
    fill_in "Initiator", with: @request_log.initiator
    fill_in "Method", with: @request_log.method
    fill_in "Request body", with: @request_log.request_body
    fill_in "Response body", with: @request_log.response_body
    fill_in "Response code", with: @request_log.response_code
    fill_in "Response headers", with: @request_log.response_headers
    fill_in "Started at", with: @request_log.started_at
    fill_in "Url", with: @request_log.url
    click_on "Update Request log"

    assert_text "Request log was successfully updated"
    click_on "Back"
  end

  test "should destroy Request log" do
    visit request_log_url(@request_log)
    click_on "Destroy this request log", match: :first

    assert_text "Request log was successfully destroyed"
  end
end
