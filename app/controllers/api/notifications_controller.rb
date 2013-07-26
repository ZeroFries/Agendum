class Api::NotificationsController < ApplicationController
	respond_to :json

	def show
	end

	def create
		# notifications only get created here if a user transfers or dismisses a task, 
		# so we look for the task in question
		@task = SentTask.find params[:task_id]
		@receiver = User.find @task.sender_id # send a message to the person who sent the task
		@sender = @task.user
		@message = "#{@sender.email} has #{params[:verb]} your task: #{@task.description[0,8]}..."
		@notification = @receiver.notifications.create message: @message, sender_id: @sender.id
		respond_with @notification, location: api_notification_url(@notification)
	end

	def index
		@user = User.where(email: params[:email]).first
		@notifications = @user.notifications
		respond_with @notifications
	end

	def destroy
	end
end
