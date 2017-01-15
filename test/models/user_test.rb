require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:dom)
  end

  test "user should be valid" do
  # assert true
    assert @user.valid?
  end

  test "first name should be present" do
    @user.first_name = "    "
    assert_not @user.valid?
  end

  test "first name should be capitalized" do
    @user.first_name = "dOMiNIC"
    @user.save
    assert_equal "Dominic", @user.first_name
  end

  test "last name should be present" do
    @user.last_name = "    "
    assert_not @user.valid?
  end

  test "last name should be capitalized" do
    @user.first_name = "michALeC"
    @user.save
    assert_equal "Michalec", @user.last_name
  end

  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "email should be downcased and stripped" do
    @user.email = "DOMJMICH@EXAMPLE.COM     "
    @user.save
    assert_equal "domjmich@example.com", @user.email
  end

  test "email should be less than 75 characters long" do
    @user.email = ("a"*64).+("@example.com")
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn)
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w(user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com)
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should have a minimum length" do
    @user.password_confirmation = @user.password = "a" * 5
    assert_not @user.valid?
  end

  test "a user should not be archived upon creation" do
    @user.save
    assert @user.archived == false
  end

  test "archival_for method should archive a user" do
    archival_for(@user)
    @user.save
    assert_equal @user.archived, true
  end

  test "unarchival_for method should unarchive a user" do
    unarchival_for(@user)
    @user.save
    assert_equal @user.archived, false
  end
end
