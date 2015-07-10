require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    # Reset deliveries array, so size = 0
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "",
                                email: "user@invalid",
                                password:  "foo",
                                password_confirmation: "bar" }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
  
  test "valid signup info with account activation" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: { name: "Example User",
                               email: "user@example.com",
                               password:  "password",
                               password_confirmation: "password" }
    end
    # Verify that exactly 1 message was delivered
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("an invalid token")
    assert_not is_logged_in?
    # Valid activation token, wrong email
    get edit_account_activation_path(user.activation_token, email: 'wrong_email')
    assert_not is_logged_in?
    # Valid activation token and email
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
