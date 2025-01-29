require "application_system_test_case"

class BusinessDimensionsTest < ApplicationSystemTestCase
  setup do
    @business_dimension = business_dimensions(:one)
  end

  test "visiting the index" do
    visit business_dimensions_url
    assert_selector "h1", text: "Business dimensions"
  end

  test "should create business dimension" do
    visit business_dimensions_url
    click_on "New business dimension"

    fill_in "Name", with: @business_dimension.name
    click_on "Create Business dimension"

    assert_text "Business dimension was successfully created"
    click_on "Back"
  end

  test "should update Business dimension" do
    visit business_dimension_url(@business_dimension)
    click_on "Edit this business dimension", match: :first

    fill_in "Name", with: @business_dimension.name
    click_on "Update Business dimension"

    assert_text "Business dimension was successfully updated"
    click_on "Back"
  end

  test "should destroy Business dimension" do
    visit business_dimension_url(@business_dimension)
    click_on "Destroy this business dimension", match: :first

    assert_text "Business dimension was successfully destroyed"
  end
end
