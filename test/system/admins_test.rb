require "application_system_test_case"

class AdminsTest < ApplicationSystemTestCase
  setup do
    @admin = admins(:one)
  end

  test "visiting the index" do
    visit admins_url
    assert_selector "h1", text: "Admins"
  end

  test "should create admin" do
    visit admins_url
    click_on "New admin"

    check "Active" if @admin.active
    fill_in "Email", with: @admin.email
    fill_in "Name", with: @admin.name
    fill_in "Password", with: @admin.password
    fill_in "Password confirmation", with: @admin.password_confirmation
    fill_in "Role", with: @admin.role_id
    click_on "Create Admin"

    assert_text "Admin was successfully created"
    click_on "Back"
  end

  test "should update Admin" do
    visit admin_url(@admin)
    click_on "Edit this admin", match: :first

    check "Active" if @admin.active
    fill_in "Email", with: @admin.email
    fill_in "Name", with: @admin.name
    fill_in "Password", with: @admin.password
    fill_in "Password confirmation", with: @admin.password_confirmation
    fill_in "Role", with: @admin.role_id
    click_on "Update Admin"

    assert_text "Admin was successfully updated"
    click_on "Back"
  end

  test "should destroy Admin" do
    visit admin_url(@admin)
    click_on "Destroy this admin", match: :first

    assert_text "Admin was successfully destroyed"
  end
end
