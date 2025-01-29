require "application_system_test_case"

class AthernusTest < ApplicationSystemTestCase
  setup do
    @athernu = athernus(:one)
  end

  test "visiting the index" do
    visit athernus_url
    assert_selector "h1", text: "Athernus"
  end

  test "should create athernu" do
    visit athernus_url
    click_on "New athernu"

    fill_in "Name", with: @athernu.name
    fill_in "Questionnaire", with: @athernu.questionnaire_id
    fill_in "Slug", with: @athernu.slug
    check "Status" if @athernu.status
    click_on "Create Athernu"

    assert_text "Athernu was successfully created"
    click_on "Back"
  end

  test "should update Athernu" do
    visit athernu_url(@athernu)
    click_on "Edit this athernu", match: :first

    fill_in "Name", with: @athernu.name
    fill_in "Questionnaire", with: @athernu.questionnaire_id
    fill_in "Slug", with: @athernu.slug
    check "Status" if @athernu.status
    click_on "Update Athernu"

    assert_text "Athernu was successfully updated"
    click_on "Back"
  end

  test "should destroy Athernu" do
    visit athernu_url(@athernu)
    click_on "Destroy this athernu", match: :first

    assert_text "Athernu was successfully destroyed"
  end
end
