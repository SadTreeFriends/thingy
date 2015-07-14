require 'test_helper'

class IdeaTest < ActiveSupport::TestCase

  def setup
    # users = users.yml fixtures
    @user = users(:michael)
    @idea = @user.ideas.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @idea.valid?
  end

  test "user id should be present" do
    @idea.user_id = nil
    assert_not @idea.valid?
  end

  test "content should be present" do
    @idea.content = "    "
    assert_not @idea.valid?
  end

  test "content should be at most 140 characters" do
    @idea.content = "a" * 141
    assert_not @idea.valid?
  end

  test "order should be most recent first" do
    # ideas = yml fixtures
    assert_equal ideas(:most_recent), Idea.first
  end
end
