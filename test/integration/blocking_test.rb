require 'test_helper'

class BlockingTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:archer)
    log_in_as(@user)
  end



                  #There is no blocking users page so this is commented out.
  # test "blocking page" do
  #   get blocking_user_path(@user)
  #   assert_not @user.blocking.empty?
  #   assert_match @user.blocking.count.to_s, response.body
  #   @user.blocking.each do |user|
  #     assert_select "a[href=?]", user_path(user)
  #   end
  # end

end
