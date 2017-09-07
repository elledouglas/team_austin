require 'test_helper'

class WinksControllerTest < ActionDispatch::IntegrationTest

  test "wink-at should require logged-in user" do
      assert_no_difference 'Wink.count' do
        post winks_path
      end
      assert_redirected_to login_url
    end

end
