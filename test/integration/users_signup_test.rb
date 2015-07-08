require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should not create user if invalid info" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "",
                                email: "user@invalid",
                                password:  "foo",
                                password_confirmation: "bar" }
    end
    assert_template 'users/new'
  end
  
  test "should create user if valid info" do
    get signup_path
    assert_difference 'User.count', 1 do
      # to follow redirect after submission
      post_via_redirect users_path, user: { name: "Example User",
                                email: "user@example.com",
                                password:  "password",
                                password_confirmation: "password" }
    end
    assert_template 'users/show'
    assert is_logged_in?
  end
end
