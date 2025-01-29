require "test_helper"

class AthernusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @athernu = athernus(:one)
  end

  test "should get index" do
    get athernus_url
    assert_response :success
  end

  test "should get new" do
    get new_athernu_url
    assert_response :success
  end

  test "should create athernu" do
    assert_difference("Athernu.count") do
      post athernus_url, params: { athernu: { name: @athernu.name, questionnaire_id: @athernu.questionnaire_id, slug: @athernu.slug, status: @athernu.status } }
    end

    assert_redirected_to athernu_url(Athernu.last)
  end

  test "should show athernu" do
    get athernu_url(@athernu)
    assert_response :success
  end

  test "should get edit" do
    get edit_athernu_url(@athernu)
    assert_response :success
  end

  test "should update athernu" do
    patch athernu_url(@athernu), params: { athernu: { name: @athernu.name, questionnaire_id: @athernu.questionnaire_id, slug: @athernu.slug, status: @athernu.status } }
    assert_redirected_to athernu_url(@athernu)
  end

  test "should destroy athernu" do
    assert_difference("Athernu.count", -1) do
      delete athernu_url(@athernu)
    end

    assert_redirected_to athernus_url
  end
end
