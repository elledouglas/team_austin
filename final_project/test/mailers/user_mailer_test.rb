require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end
  def welcome_email
    UserMailer.welcome_email(User.first)
  end
end
