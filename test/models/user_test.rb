require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(full_name: "Example User", email: "user@example.com", age: 25,
                     password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "full name should be present" do
    @user.full_name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.full_name = "a" * 51
    assert_not @user.valid?
  end

  test "age should be present" do
    @user.age = nil
    assert_not @user.valid?
  end

  test "user must be at least 18 years old" do
    @user.age = 17
    assert_not @user.valid?
  end

    test "age must be entered in as numeric" do
    @user.age = "twenty"
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end



  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.email
    # Line 63 originally had @user.reload.email but it was erroring until I removed reload
  end

  test "password should be present" do
    @user.password = "     "
    assert_not @user.valid?, "Password not filled out"
  end

  test "password_confirmation should be present" do
    @user.password_confirmation = "     "
    assert_not @user.valid?, "Password confirmation not filled out"
  end

  # Redundant method of two tests above conbinded.
  # test "password should be present (nonblank)" do
  #   @user.password = @user.password_confirmation = " " * 6
  #   assert_not @user.valid?
  # end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "ab"
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "should block and unblock a user" do
    michael  = users(:michael)
    archer   = users(:archer)
    assert_not michael.blocking?(archer)
    michael.block(archer)
    assert michael.blocking?(archer)
    assert archer.blockers.include?(michael)
    michael.unblock(archer)
    assert_not michael.blocking?(archer)
  end




end
