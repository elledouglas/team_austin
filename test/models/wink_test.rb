require 'test_helper'

class WinkTest < ActiveSupport::TestCase

    def setup
      @wink = Wink.new(wink_sender_id: users(:michael).id,
                       wink_recipient_id: users(:archer).id,
                       created_at: Time.now + (2*7*24*60*60))
    end

    test "wink should be valid" do
      assert @wink.valid?
    end

    test "should require a follower_id" do
      @wink.wink_sender_id = nil
      assert_not @wink.valid?
    end

    test "should require a followed_id" do
      @wink.wink_recipient_id = nil
      assert_not @wink.valid?
    end

    test "should wink at a user" do
      michael = users(:michael)
      archer  = users(:archer)
      assert_not michael.winked_at?(archer)
      michael.wink_at(archer)
      assert michael.winked_at?(archer)

      # michael.unfollow(archer)
      # assert_not michael.following?(archer)
    end
end
