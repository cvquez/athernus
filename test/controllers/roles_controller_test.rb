require "test_helper"

class RolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @role = roles(:one)
  end

  test "should get index" do
    get roles_url
    assert_response :success
  end

  test "should get new" do
    get new_role_url
    assert_response :success
  end

  test "should create role" do
    assert_difference('Role.count') do
      post roles_url, params: { role: { admin_create: @role.admin_create, admin_delete: @role.admin_delete, admin_read: @role.admin_read, admin_update: @role.admin_update, banner_create: @role.banner_create, banner_delete: @role.banner_delete, banner_read: @role.banner_read, banner_update: @role.banner_update, name: @role.name, product_create: @role.product_create, product_delete: @role.product_delete, product_read: @role.product_read, product_update: @role.product_update, role_create: @role.role_create, role_delete: @role.role_delete, role_read: @role.role_read, role_update: @role.role_update } }
    end

    assert_redirected_to role_url(Role.last)
  end

  test "should show role" do
    get role_url(@role)
    assert_response :success
  end

  test "should get edit" do
    get edit_role_url(@role)
    assert_response :success
  end

  test "should update role" do
    patch role_url(@role), params: { role: { admin_create: @role.admin_create, admin_delete: @role.admin_delete, admin_read: @role.admin_read, admin_update: @role.admin_update, banner_create: @role.banner_create, banner_delete: @role.banner_delete, banner_read: @role.banner_read, banner_update: @role.banner_update, name: @role.name, product_create: @role.product_create, product_delete: @role.product_delete, product_read: @role.product_read, product_update: @role.product_update, role_create: @role.role_create, role_delete: @role.role_delete, role_read: @role.role_read, role_update: @role.role_update } }
    assert_redirected_to role_url(@role)
  end

  test "should destroy role" do
    assert_difference('Role.count', -1) do
      delete role_url(@role)
    end

    assert_redirected_to roles_url
  end
end
