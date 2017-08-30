require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "login with invalid information" do
    # Visit login path and verify that the new sessions form renders properly
    get login_path
    assert_template 'sessions/new'
    # Post to the sessions path with an invalid params hash, verify that
    # the new sessions form gets re-render and flash message appears
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    # Vist another page (home), verify that the flash emssage doesn't still appear on new page.
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    # 1. This test signs in using user template
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    # 2. Test assertion that upon login user is redirected to home
    assert is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/home'
    # 3. Asserts that the user won't find the login path anymore
    assert_select "a[href=?]", login_path, count: 0
    # 4. Asserts that that logout link will be found
    assert_select "a[href=?]", logout_path
    # assert_select "a[href=?]", user_path(@user)  # Not accurate path at this time, have to refactor.
    # Three lines below: logout and assert that user redirected to root, even though we were already in root.
    delete logout_path
    assert_redirected_to root_url
    follow_redirect!
    # Three lines below assert that login link will be found, while logout and user profile links will not be found.
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    # assert_select "a[href=?]", user_path(@user), count: 0 # Path not accurate at this time, have to refactor.
  end

end
