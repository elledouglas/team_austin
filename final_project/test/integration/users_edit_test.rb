require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    get edit_user_profile_path(@user)
    assert_template 'users/edit'
    patch user_profile_path(@user), params: { user: { full_name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end

  test "successful edit" do
    get edit_user_profile_path(@user)
    assert_template 'users/edit'
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

end
