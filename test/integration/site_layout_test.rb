require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "home page layout links" do
    # This simply asserts that the home page links are what we expect them to be.
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", signup_path
  end

end
