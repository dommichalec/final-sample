# rails g integration_test user_signin
require 'test_helper'

class UserSigninTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:dom)
  end

  test "unsuccessful sign in should yield a flash message only upon render" do
    get signin_path
    assert_template 'sessions/new'
    post signin_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    get signin_path
    post signin_path, params: { session: { email:    @user.email,
                                          password: 'password1' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", signin_path, count: 0
    assert_select "a[href=?]", signout_path
    assert_select "a[href=?]", user_path(@user)
    delete signout_path
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", signin_path
    assert_select "a[href=?]", signout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with invalid information" do
    get signin_path
    post signin_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert_template 'sessions/new'
    assert_select "a[href=?]", signin_path, count: 1
    assert_select "a[href=?]", signout_path, count: 0
  end
end
