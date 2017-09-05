class User < ApplicationRecord
  has_many :active_block_relationships, class_name:  "BlockRelationship",
                                foreign_key: "blocker_id",
                                dependent:   :destroy
  has_many :passive_block_relationships, class_name:  "BlockRelationship",
                               foreign_key: "blocked_id",
                               dependent:   :destroy
  has_many :blocking, through: :active_block_relationships, source: :blocked
  has_many :blockers, through: :passive_block_relationships, source: :blocker



  # attr_accessible :email, :password, :password_confirmation
  attr_accessor :remember_token, :activation_token, :reset_token

  # Validations for full_name
  validates :full_name,  presence: true, length: { maximum: 50 }

  # Validations for email
  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX, message: "not valid"},
                    uniqueness: { case_sensitive: false }

  # Validations for password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
  has_secure_password

  mount_uploader :video, VideoUploader
  mount_uploader :image, ImageUploader

  def index

  end

  def new
      @user = User.new
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Checks whether a password is needed or not. For validations only.
  # Passwords are always required if it's a new record, or if the password
  # or confirmation are being set somewhere.
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  # Returns a random token (for remember me sign-in option)
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # METHODS FOR PASSWORD RESET

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # METHODS FOR USER BLOCKING FUNCTIONALITY

  # blocks a user.
  def block(other_user)
    blocking << other_user
  end

  # Unblocks a user.
  def unblock(other_user)
    blocking.delete(other_user)
  end

  # Returns true if the current user is blocking the other user.
  def blocking?(other_user)
    blocking.include?(other_user)
  end


end
