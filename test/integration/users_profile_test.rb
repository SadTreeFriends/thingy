require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'   # check inside h1 for img tag with class gravatar
    assert_match @user.ideas.count.to_s, response.body
    assert_select 'div.pagination'
    @user.ideas.paginate(page: 1).each do |idea|
      assert_match idea.content, response.body
    end
    # Stats test
    assert_match @user.following.count.to_s, response.body
    assert_match @user.followers.count.to_s, response.body
  end
end
