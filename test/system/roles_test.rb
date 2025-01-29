require "application_system_test_case"

class RolesTest < ApplicationSystemTestCase
  setup do
    @role = roles(:one)
  end

  test "visiting the index" do
    visit roles_url
    assert_selector "h1", text: "Roles"
  end

  test "creating a Role" do
    visit roles_url
    click_on "New Role"

    check "Admin create" if @role.admin_create
    check "Admin delete" if @role.admin_delete
    check "Admin read" if @role.admin_read
    check "Admin update" if @role.admin_update
    check "Banner create" if @role.banner_create
    check "Banner delete" if @role.banner_delete
    check "Banner read" if @role.banner_read
    check "Banner update" if @role.banner_update
    fill_in "Name", with: @role.name
    check "Product create" if @role.product_create
    check "Product delete" if @role.product_delete
    check "Product read" if @role.product_read
    check "Product update" if @role.product_update
    check "Role create" if @role.role_create
    check "Role delete" if @role.role_delete
    check "Role read" if @role.role_read
    check "Role update" if @role.role_update
    click_on "Create Role"

    assert_text "Role was successfully created"
    click_on "Back"
  end

  test "updating a Role" do
    visit roles_url
    click_on "Edit", match: :first

    check "Admin create" if @role.admin_create
    check "Admin delete" if @role.admin_delete
    check "Admin read" if @role.admin_read
    check "Admin update" if @role.admin_update
    check "Banner create" if @role.banner_create
    check "Banner delete" if @role.banner_delete
    check "Banner read" if @role.banner_read
    check "Banner update" if @role.banner_update
    fill_in "Name", with: @role.name
    check "Product create" if @role.product_create
    check "Product delete" if @role.product_delete
    check "Product read" if @role.product_read
    check "Product update" if @role.product_update
    check "Role create" if @role.role_create
    check "Role delete" if @role.role_delete
    check "Role read" if @role.role_read
    check "Role update" if @role.role_update
    click_on "Update Role"

    assert_text "Role was successfully updated"
    click_on "Back"
  end

  test "destroying a Role" do
    visit roles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Role was successfully destroyed"
  end
end
