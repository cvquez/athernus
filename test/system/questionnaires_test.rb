require "application_system_test_case"

class QuestionnairesTest < ApplicationSystemTestCase
  setup do
    @questionnaire = questionnaires(:one)
  end

  test "visiting the index" do
    visit questionnaires_url
    assert_selector "h1", text: "Questionnaires"
  end

  test "should create questionnaire" do
    visit questionnaires_url
    click_on "New questionnaire"

    fill_in "Name", with: @questionnaire.name
    fill_in "Questionnaire type", with: @questionnaire.questionnaire_type_id
    fill_in "Slug", with: @questionnaire.slug
    check "Status" if @questionnaire.status
    click_on "Create Questionnaire"

    assert_text "Questionnaire was successfully created"
    click_on "Back"
  end

  test "should update Questionnaire" do
    visit questionnaire_url(@questionnaire)
    click_on "Edit this questionnaire", match: :first

    fill_in "Name", with: @questionnaire.name
    fill_in "Questionnaire type", with: @questionnaire.questionnaire_type_id
    fill_in "Slug", with: @questionnaire.slug
    check "Status" if @questionnaire.status
    click_on "Update Questionnaire"

    assert_text "Questionnaire was successfully updated"
    click_on "Back"
  end

  test "should destroy Questionnaire" do
    visit questionnaire_url(@questionnaire)
    click_on "Destroy this questionnaire", match: :first

    assert_text "Questionnaire was successfully destroyed"
  end
end
