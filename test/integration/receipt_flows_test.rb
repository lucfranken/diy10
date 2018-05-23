require 'test_helper'

# puts @response.parsed_body

class ReceiptFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:john)
  end

  test "New receipt upload" do
    get root_path
    assert_select '#receipts-amount-processing', '1'

    post receipts_path,
      params: {
        receipt: {
          name: 'test'
        }
      }
    assert_redirected_to root_path
    follow_redirect!

    # And put into the processed list
    assert_select '#receipts-amount-processing', '2'
  end
end
