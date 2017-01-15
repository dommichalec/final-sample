# rails g integration_test user_edit
require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:dom)
  end

  test "unsuccessful edit should render edit page again" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { first_name:  "",
                                              last_name: "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end

  test "successful edit should redirect to user profile page" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { first_name:  "Dominic",
                                              last_name: "Michalec",
                                              email: "new@example.com",
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    @user.reload
    assert_equal "Dominic",  @user.first_name
    assert_equal "Michalec",  @user.last_name
    assert_equal "new@example.com", @user.email
    assert_redirected_to user_path(@user)
  end
end
