require 'test_helper'

# puts @response.parsed_body

class ReceiptAdminFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:admin)
  end

  test "Admin see list of receipts" do
    get admin_receipts_path
    assert_select ".receipt-#{receipts(:waitingreceipt).id}"
  end

  test "Admin edit to see waiting receipt" do
    get edit_admin_receipt_path receipts(:waitingreceipt)

    assert_response :success
  end

  test "Admin process waiting receipt" do
    patch admin_receipt_path receipts(:waitingreceipt).id,
      params: {
        receipt: {
          total: 44,
          status: 'processed'
        }
      }
    assert_redirected_to admin_receipts_path
    follow_redirect!

    # It's now removed from the infex
    assert_select ".receipt-#{receipts(:waitingreceipt).id}", false

    # And put into the processed list
    get admin_scope_path(:processed)
    assert_select ".receipt-#{receipts(:waitingreceipt).id}"

  end

  test "Admin save and check calculations" do
    patch admin_receipt_path receipts(:waitingreceipt).id,
      params: {
        receipt: {
          value: '105,15',
          status: 'processed',

          lines_attributes: {
              '0': {
                amount: 1,
                description: 'test description',
                price: 55,
                price_total: 55,
              },
              '1': {
                amount: 5,
                description: 'test description 2',
                price: '10,03',
                # TODO: FIX DECIMALS SEPARATOR?
                price_total: '50,15', 
              },
          }
        }
      }

    assert_redirected_to admin_receipts_path
    follow_redirect!

    get edit_admin_receipt_path receipts(:waitingreceipt)
    
    assert_select '#receipt_value[value=?]', '105,15'
    
    assert_select '#receipt_lines_attributes_0_amount[value=?]', '1'
    assert_select '#receipt_lines_attributes_0_description[value=?]', 'test description'
    assert_select '#receipt_lines_attributes_0_price[value=?]', '55,00'
    assert_select '#receipt_lines_attributes_0_price_total[value=?]', '55,00'
    
    assert_select '#receipt_lines_attributes_1_amount[value=?]', '5'
    assert_select '#receipt_lines_attributes_1_description[value=?]', 'test description 2'
    assert_select '#receipt_lines_attributes_1_price[value=?]', '10,03'
    assert_select '#receipt_lines_attributes_1_price_total[value=?]', '50,15'
  end

end
