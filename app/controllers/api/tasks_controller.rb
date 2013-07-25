class Api::TasksController < ApplicationController
	respond_to :json

	def new
		@task = Task.new
	end

	def create
		@user = User.where(email: params["email"]).first
		@task = @user.tasks.create task_params
		respond_with @task, location: "api/task"
	end

	def index
		@user = User.where(email: params["email"]).first
		@tasks = @user.tasks
		respond_with @tasks
	end

	def destroy
		@task = Task.find params[:id]
		@task.destroy
		respond_with @task, location: '/api/tasks'
	end

	private

	def task_params
		params.permit :description
	end
end
