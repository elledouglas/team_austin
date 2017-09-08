require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_profile_path(@user)
    assert_template 'users/edit'
    patch user_profile_path(@user), params: { user: { full_name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_profile_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_profile_path(@user)
    full_name = "Foo Bar"
    email = "foo@bar.com"
    patch user_profile_path(@user), params: { user: { full_name: full_name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert flash.empty? == false # Assert false to the question is there no flash message?
    assert_redirected_to user_profile_path(@user)
    @user.reload
    assert_equal full_name, @user.full_name
    assert_equal email, @user.email
  end

  # This test checks that forwarding URL is not remembered after friendly redirect occurs, so to prevent user be
  # redirected when they don't want to be.
  test "friendly forwarding only occurs once" do
    get edit_user_profile_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_profile_path(@user)
    # log_out
    # log_in_as(@user)
    # assert_redirected_to root_path

    # \/ Does same thing as 3 lines above /\
    assert session[:forwarding_url] == nil
  end

end
