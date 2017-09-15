require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post create_user_path, params: { user: { full_name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do     # this line asserts there is a diff of 1 in the amount of users
      post create_user_path, params: { user: { full_name:  "Example User",
                                         email: "user@example.com",
                                         age: 30,
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!                 # these two lines establish that the redirect after user submission works as expected
    assert_template 'users/index'
    assert is_logged_in?
  end

end
