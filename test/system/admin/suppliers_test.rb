require "application_system_test_case"

class Admin::SuppliersTest < ApplicationSystemTestCase
  setup do
    @admin_supplier = admin_suppliers(:one)
  end

  test "visiting the index" do
    visit admin_suppliers_url
    assert_selector "h1", text: "Admin/Suppliers"
  end

  test "creating a Supplier" do
    visit admin_suppliers_url
    click_on "New Admin/Supplier"

    fill_in "Name", with: @admin_supplier.name
    click_on "Create Supplier"

    assert_text "Supplier was successfully created"
    click_on "Back"
  end

  test "updating a Supplier" do
    visit admin_suppliers_url
    click_on "Edit", match: :first

    fill_in "Name", with: @admin_supplier.name
    click_on "Update Supplier"

    assert_text "Supplier was successfully updated"
    click_on "Back"
  end

  test "destroying a Supplier" do
    visit admin_suppliers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Supplier was successfully destroyed"
  end
end
