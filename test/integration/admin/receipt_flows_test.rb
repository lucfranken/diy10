require 'test_helper'

# puts @response.parsed_body

class ReceiptFlowsTest < ActionDispatch::IntegrationTest
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

    # puts receipts(:waitingreceipt).inspect
    # puts @response.parsed_body

    # It's now removed from the infex
    assert_select ".receipt-#{receipts(:waitingreceipt).id}", false

    # And put into the processed list
    get admin_scope_path(:processed)
    assert_select ".receipt-#{receipts(:waitingreceipt).id}"

  end

end
