# rails g integration_test user_signup
require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test "an unsuccessful sign up attempt should not add a user to the db" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                     email: "user@invalid",
                                     password:              "foo",
                                     password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert !is_logged_in?
  end

  test "a successful sign up attempt should add one user to the db" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { first_name:  "Example",
                                         last_name: "User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_not flash.empty?
    assert_template 'users/show'
    assert is_logged_in?
  end
end
