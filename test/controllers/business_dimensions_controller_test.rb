require "test_helper"

class BusinessDimensionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @business_dimension = business_dimensions(:one)
  end

  test "should get index" do
    get business_dimensions_url
    assert_response :success
  end

  test "should get new" do
    get new_business_dimension_url
    assert_response :success
  end

  test "should create business_dimension" do
    assert_difference("BusinessDimension.count") do
      post business_dimensions_url, params: { business_dimension: { name: @business_dimension.name } }
    end

    assert_redirected_to business_dimension_url(BusinessDimension.last)
  end

  test "should show business_dimension" do
    get business_dimension_url(@business_dimension)
    assert_response :success
  end

  test "should get edit" do
    get edit_business_dimension_url(@business_dimension)
    assert_response :success
  end

  test "should update business_dimension" do
    patch business_dimension_url(@business_dimension), params: { business_dimension: { name: @business_dimension.name } }
    assert_redirected_to business_dimension_url(@business_dimension)
  end

  test "should destroy business_dimension" do
    assert_difference("BusinessDimension.count", -1) do
      delete business_dimension_url(@business_dimension)
    end

    assert_redirected_to business_dimensions_url
  end
end
