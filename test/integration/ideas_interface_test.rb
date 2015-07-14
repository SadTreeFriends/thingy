require 'test_helper'

class IdeasInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
  
  test "idea interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
    assert_no_difference 'Idea.count' do
      post ideas_path, idea: { content: "" }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    content = 'This idea really ties the room together'
    assert_difference 'Idea.count', 1 do
      post ideas_path, idea: { content: content }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete a post.
    assert_select 'a', text: 'delete'
    first_idea = @user.ideas.paginate(page: 1).first
    assert_difference 'Idea.count', -1 do
      delete idea_path(first_idea)
    end
    # Visit a different user.
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
