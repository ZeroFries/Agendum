require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  setup do
  	@task = FactoryGirl.create :task
  end

  test "tasks must have a description" do
  	@task.description = ""

  	assert !@task.save
  end

  test "tasks have an owner" do
  	refute @task.user.nil?
  end
end
