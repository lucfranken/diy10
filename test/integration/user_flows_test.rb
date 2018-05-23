require 'test_helper'


# puts @response.parsed_body

class UserFlowsTest < ActionDispatch::IntegrationTest
  test "/ redirects to login" do
    get "/"
    assert_redirected_to new_user_session_path
  end

  test "can register" do
    get new_user_registration_path
    assert_response :success

    post user_registration_path,
      params: {
        user: {
        email: 'test12345@example.com',
        password: 'password',
        password_confirmation: 'password',
      }
    }
    assert_response :redirect
    follow_redirect!

    assert_select 'body.logged-in'
  end

  test "can register, logout and back login" do
    get new_user_registration_path
    assert_response :success

    post user_registration_path,
      params: {
        user: {
        email: 'test12345@example.com',
        password: 'password',
        password_confirmation: 'password',
      }
    }

    assert_response :redirect
    follow_redirect!

    assert_select 'body.logged-in'

    delete destroy_user_session_path

    assert_response :redirect
    follow_redirect!

    # back at login form
    post new_user_session_path,
      params: {
        user: {
        email: 'test12345@example.com',
        password: 'password',
      }
    }

    assert_response :redirect
    follow_redirect!

    assert_select 'body.logged-in'
  end
end
