class User < ApplicationRecord
  # attr_accessible :email, :password, :password_confirmation

  # Validations for full_name
  validates :full_name,  presence: true, length: { maximum: 50 }
  # Validations for email
  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX, message: "not valid"},
                    uniqueness: { case_sensitive: false }

  # Validations for password
  validates :password, length: {minimum: 8}, confirmation: true, presence: true,:if => :password_required?
  has_secure_password
  mount_uploader :video, VideoUploader
  mount_uploader :image, ImageUploader
  def index

  end

  def new
      @user = User.new
  end

  # Checks whether a password is needed or not. For validations only.
  # Passwords are always required if it's a new record, or if the password
  # or confirmation are being set somewhere.
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end



end
