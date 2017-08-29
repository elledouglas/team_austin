require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

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

end
