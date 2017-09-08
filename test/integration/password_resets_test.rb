require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)
  end

  def reset_password_form
    # submit need a new password form, prep method to be used in tests
    get new_password_reset_path
    post password_resets_path,
         params: { password_reset: { email: @user.email } }
  end

  test "password reset link with invalid email" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # Invalid email
    post password_resets_path, params: { password_reset: { email: "" } }
    assert_not flash.empty?
    assert_template 'password_resets/new'
  end

  test "password reset link with valid email" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # Valid email
    post password_resets_path,
         params: { password_reset: { email: @user.email } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "wrong email redirects to root" do
    reset_password_form
    user = assigns(:user)
    # Wrong email
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to root_url
  end

  test "wrong token redirects to root" do
    reset_password_form
    user = assigns(:user)
    # Right email, wrong token
    get edit_password_reset_path('wrong token', email: user.email)
    assert_redirected_to root_url
  end

  # test "right token allows password reset page" do
  #   reset_password_form
  #   user = assigns(:user)
  #   # Right email, right token
  #   get edit_password_reset_path(user.reset_token, email: user.email)
  #   assert_template 'password_resets/edit'
  #   assert_select "input[name=email][type=hidden][value=?]", user.email
  # end

  # test "invalid or empty password fails" do
  #   reset_password_form
  #   user = assigns(:user)
  #   # Wrong password
  #   patch password_reset_path(user.reset_token),
  #         params: { email: user.email,
  #                   user: { password:              "rightpass",
  #                           password_confirmation: "wrongpass" } }
  #   assert_select 'div#error_explanation'
  #   # Empty password
  #   patch password_reset_path(user.reset_token),
  #         params: { email: user.email,
  #                   user: { password:              "",
  #                           password_confirmation: "" } }
  #   assert_select 'div#error_explanation'
  # end

  # test "valid password and confirmation results in log in" do
  #   reset_password_form
  #   user = assigns(:user)
  #  # Valid password & confirmation
  #   patch password_reset_path(user.reset_token),
  #         params: { email: user.email,
  #                   user: { password:              "password",
  #                           password_confirmation: "password" } }
  #   assert is_logged_in?
  #   assert_not flash.empty?
  #   assert_redirected_to user
  # end

end
