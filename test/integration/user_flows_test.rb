require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  test "/ redirects to login" do
    get "/"
    assert_redirected_to new_user_session_path
  end
end
