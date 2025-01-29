require "test_helper"

class QuestionnaireTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @questionnaire_type = questionnaire_types(:one)
  end

  test "should get index" do
    get questionnaire_types_url
    assert_response :success
  end

  test "should get new" do
    get new_questionnaire_type_url
    assert_response :success
  end

  test "should create questionnaire_type" do
    assert_difference("QuestionnaireType.count") do
      post questionnaire_types_url, params: { questionnaire_type: { name: @questionnaire_type.name } }
    end

    assert_redirected_to questionnaire_type_url(QuestionnaireType.last)
  end

  test "should show questionnaire_type" do
    get questionnaire_type_url(@questionnaire_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_questionnaire_type_url(@questionnaire_type)
    assert_response :success
  end

  test "should update questionnaire_type" do
    patch questionnaire_type_url(@questionnaire_type), params: { questionnaire_type: { name: @questionnaire_type.name } }
    assert_redirected_to questionnaire_type_url(@questionnaire_type)
  end

  test "should destroy questionnaire_type" do
    assert_difference("QuestionnaireType.count", -1) do
      delete questionnaire_type_url(@questionnaire_type)
    end

    assert_redirected_to questionnaire_types_url
  end
end
