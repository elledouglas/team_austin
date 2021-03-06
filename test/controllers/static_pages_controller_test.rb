require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  # test "should get home" do
  #   get static_pages_home_url
  #   assert_response :success
  # end
  #
  # test "should get about" do
  #   get static_pages_about_url
  #   assert_response :success
  # end

  def setup
    @base_title = "Noble Dating"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end
end
