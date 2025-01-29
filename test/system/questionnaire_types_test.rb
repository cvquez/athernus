require "application_system_test_case"

class QuestionnaireTypesTest < ApplicationSystemTestCase
  setup do
    @questionnaire_type = questionnaire_types(:one)
  end

  test "visiting the index" do
    visit questionnaire_types_url
    assert_selector "h1", text: "Questionnaire types"
  end

  test "should create questionnaire type" do
    visit questionnaire_types_url
    click_on "New questionnaire type"

    fill_in "Name", with: @questionnaire_type.name
    click_on "Create Questionnaire type"

    assert_text "Questionnaire type was successfully created"
    click_on "Back"
  end

  test "should update Questionnaire type" do
    visit questionnaire_type_url(@questionnaire_type)
    click_on "Edit this questionnaire type", match: :first

    fill_in "Name", with: @questionnaire_type.name
    click_on "Update Questionnaire type"

    assert_text "Questionnaire type was successfully updated"
    click_on "Back"
  end

  test "should destroy Questionnaire type" do
    visit questionnaire_type_url(@questionnaire_type)
    click_on "Destroy this questionnaire type", match: :first

    assert_text "Questionnaire type was successfully destroyed"
  end
end
