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
        email: 'test_user_flows_test@example.com',
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
        email: 'test_user_flows_test@example.com',
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
        email: 'test_user_flows_test@example.com',
        password: 'password',
      }
    }

    assert_response :redirect
    follow_redirect!

    assert_select 'body.logged-in'
  end

  test "normal user cannot go to admin" do
    # back at login form
    post new_user_session_path,
      params: {
        user: {
        email: 'john@example.com',
        password: 'passwordjohn',
      }
    }

    assert_response :redirect
    follow_redirect!

    assert_raise RuntimeError do
      get admin_dashboards_path
    end

    assert_raise RuntimeError do
      get admin_suppliers_path
    end
  end

  test "admin goes to dashboards" do
    # back at login form
    post new_user_session_path,
      params: {
        user: {
        email: 'admin@example.com',
        password: 'passwordadmin',
      }
    }

    assert_response :redirect
    follow_redirect!

    assert_select '.dashboards'
    assert_select '.logged-in-admin'
  end
end
