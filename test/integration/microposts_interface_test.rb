require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:dom)
  end

  test "micropost interface for invalid submission" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination' # makes sure we have pagination on the home screen
    # Invalid submission
    assert_no_difference 'Micropost.count' do
      post microposts_path, micropost: { content: "" }
      assert_select 'div#error_explanation' # makes sure we see a div with id of 'error explanation' after invalid post
    end
    # Valid  submission
    content = "This is the content for the new micropost"
    assert_difference 'Micropost.count', 1 do
      post microposts_path, micropost: { content: content }
    end
    assert_redirected_to root_url
    follow_redirect! # follow redirect to make sure the content was posted to the next page successfully
    assert_match content, response.body
    # Delete a post
    assert_select 'a', text: 'delete' # to make sure there's a delete link on the page
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    # Visit another user's profile page
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0 # there should be zero delete links present on another user's profile page
  end
end
