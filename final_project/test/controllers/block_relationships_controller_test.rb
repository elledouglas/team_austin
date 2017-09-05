require 'test_helper'

class BlockRelationshipsControllerTest < ActionDispatch::IntegrationTest

  test "create block should require logged-in user" do
    assert_no_difference 'BlockRelationship.count' do
      post block_relationships_path
    end
    assert_redirected_to login_url
  end

  test "destroy/unblock should require logged-in user" do
    assert_no_difference 'BlockRelationship.count' do
      delete block_relationship_path(block_relationships(:one))
    end
    assert_redirected_to login_url
  end
end
