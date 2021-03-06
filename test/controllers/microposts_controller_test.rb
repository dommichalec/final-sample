require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @micropost = microposts(:tau_manifesto)
  end

  test "should redirect create to log in url when not logged in" do
    assert_no_difference 'Micropost.count' do
      post :create, micropost: { content: "Lorem ipsum" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy to log in url when not logged in" do
    assert_no_difference 'Micropost.count' do
      delete :destroy, id: @micropost
    end
    assert_redirected_to login_url
  end

  test "should not be able to delete the micropost of another user" do
    log_in_as(users(:dom))
    assert_no_difference Micropost.count do
      delete :destroy, id: micropost(:cat_video)
    end
  end
end
