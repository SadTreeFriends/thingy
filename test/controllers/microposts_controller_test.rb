require 'test_helper'

class IdeasControllerTest < ActionController::TestCase

  def setup
    @idea = ideas(:orange)
  end

  test "should redirect CREATE when not logged in" do
    assert_no_difference 'Idea.count' do
      post :create, idea: { content: "Lorem ipsum" }
    end
    assert_redirected_to login_url
  end

  test "should redirect DESTROY when not logged in" do
    assert_no_difference 'Idea.count' do
      delete :destroy, id: @idea
    end
    assert_redirected_to login_url
  end
  
  test "should redirect DESTROY for other user's idea" do
    log_in_as(users(:michael))
    idea = ideas(:ants)
    assert_no_difference 'Idea.count' do
      delete :destroy, id: idea
    end
    assert_redirected_to root_url
  end
end
