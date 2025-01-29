require "application_system_test_case"

class FocusAreasTest < ApplicationSystemTestCase
  setup do
    @focus_area = focus_areas(:one)
  end

  test "visiting the index" do
    visit focus_areas_url
    assert_selector "h1", text: "Focus areas"
  end

  test "should create focus area" do
    visit focus_areas_url
    click_on "New focus area"

    fill_in "Name", with: @focus_area.name
    click_on "Create Focus area"

    assert_text "Focus area was successfully created"
    click_on "Back"
  end

  test "should update Focus area" do
    visit focus_area_url(@focus_area)
    click_on "Edit this focus area", match: :first

    fill_in "Name", with: @focus_area.name
    click_on "Update Focus area"

    assert_text "Focus area was successfully updated"
    click_on "Back"
  end

  test "should destroy Focus area" do
    visit focus_area_url(@focus_area)
    click_on "Destroy this focus area", match: :first

    assert_text "Focus area was successfully destroyed"
  end
end
