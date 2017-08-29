require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

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

  # Have not implemented edit and destroy yet

  # test "should get edit" do
  #   get users_edit_url
  #   assert_response :success
  # end

  # test "should get destroy" do
  #   get users_destroy_url
  #   assert_response :success
  # end

end
