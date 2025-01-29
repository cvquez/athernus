require "test_helper"

class SiteControllerTest < ActionDispatch::IntegrationTest
  test "should get athernus" do
    get site_athernus_url
    assert_response :success
  end
end
