require 'test_helper'

class BlockRelationshipTest < ActiveSupport::TestCase

  def setup
    @block_relationship = BlockRelationship.new(blocker_id: users(:michael).id,
                                     blocked_id: users(:archer).id)
  end

  test "should be valid" do
    assert @block_relationship.valid?
  end

  test "should require a blocker_id" do
    @block_relationship.blocker_id = nil
    assert_not @block_relationship.valid?
  end

  test "should require a blocked_id" do
    @block_relationship.blocked_id = nil
    assert_not @block_relationship.valid?
  end
end
