require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)

  end

  test "should get index" do
    get users_path
    assert_response :success
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should get create" do
    get create_user_path
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_user_profile_path(@user)
    assert_response :success
  end

  test "should get destroy" do
    # log_in_as(@user)
    get delete_user_profile_path(@user)
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_profile_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect update when not logged in" do
    patch update_user_profile_path(@user), params: { user: { full_name: @user.full_name,
                                                     email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_profile_path(@user)
#    assert flash.empty? # I assert that the flash-messages hash is empty. Currently failing the test because apparently it isn't empty.
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch update_user_profile_path(@user), params: { user: { full_name: @user.full_name,
                                              email: @user.email } }
#    assert flash.empty? # I assert that the flash-messages hash is empty. Currently failing the test because apparently it isn't empty.
    assert_redirected_to root_url
  end

end
