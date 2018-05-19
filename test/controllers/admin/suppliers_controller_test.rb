require 'test_helper'

class Admin::SuppliersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_supplier = admin_suppliers(:one)
  end

  test "should get index" do
    get admin_suppliers_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_supplier_url
    assert_response :success
  end

  test "should create admin_supplier" do
    assert_difference('Admin::Supplier.count') do
      post admin_suppliers_url, params: { admin_supplier: { name: @admin_supplier.name } }
    end

    assert_redirected_to admin_supplier_url(Admin::Supplier.last)
  end

  test "should show admin_supplier" do
    get admin_supplier_url(@admin_supplier)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_supplier_url(@admin_supplier)
    assert_response :success
  end

  test "should update admin_supplier" do
    patch admin_supplier_url(@admin_supplier), params: { admin_supplier: { name: @admin_supplier.name } }
    assert_redirected_to admin_supplier_url(@admin_supplier)
  end

  test "should destroy admin_supplier" do
    assert_difference('Admin::Supplier.count', -1) do
      delete admin_supplier_url(@admin_supplier)
    end

    assert_redirected_to admin_suppliers_url
  end
end
