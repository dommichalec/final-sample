# rails g integration_test user_profile
require 'test_helper'

class UserProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:dom)
  end

  test "should display the profile" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.full_name)
    assert_select 'h1', text: @user.full_name
    assert_select 'h1>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.each do |micropost|
      assert_select micropost.content, response.body
    end
  end
end
