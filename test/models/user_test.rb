require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
  	@user = FactoryGirl.create :user
  end

  test "must have email" do
  	@user.email = ""

  	assert !@user.save
  end

  test "must have valid email" do
  	@user.email = "hi"

  	assert !@user.save
  end

  test "must have password with 5 characters" do
  	@user.password = "hihi"
  	@user.password_confirmation = "hihi"

  	assert !@user.save
  end

  test "password and password_confirmation must match" do
  	@user.password = "hihihi"
  	@user.password_confirmation = "hihiyo"

  	assert !@user.save
  end

  test "no two users can have the same email" do
    @user2 = FactoryGirl.build :user

    assert !@user2.save
  end

  test "deleting a user deletes their tasks" do
    task = @user.tasks.create description: "test"
    user_size = User.all.size
    task_size = Task.all.size
    @user.destroy

    assert_equal User.all.size + 1, user_size
    assert_equal Task.all.size + 1, task_size
  end
end
