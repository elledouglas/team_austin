class BlockRelationship < ApplicationRecord
  belongs_to :blocker, class_name: "User"
  belongs_to :blocked, class_name: "User"
  validates :blocker_id, presence: true
  validates :blocked_id, presence: true

  belongs_to :wink_sender, class_name: "User"
  belongs_to :wink_recipient, class_name: "User"
  validates :wink_sender_id, presence: true
  validates :wink_recipient_id, presence: true


  has_many :active_block_relationships, class_name:  "BlockRelationship",
                                foreign_key: "blocker_id",
                                dependent:   :destroy
  has_many :passive_block_relationships, class_name:  "BlockRelationship",
                               foreign_key: "blocked_id",
                               dependent:   :destroy

  has_many :blocking, through: :active_block_relationships, source: :blocked
  has_many :blockers, through: :passive_block_relationships, source: :blocker


end
