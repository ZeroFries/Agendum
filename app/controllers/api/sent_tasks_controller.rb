class Api::SentTasksController < ApplicationController
	respond_to :json

	def show
		@task = SentTask.find params[:id]
		respond_with @task
	end

	def create
		@sender = User.where(email: params[:sender_email]).first
		puts @sender
		bad_emails = []
		@tasks = []
		params[:emails].split(";").each do |email|
			email.strip!
			@receiver = User.where(email: email).first
			if @receiver.nil?
				bad_emails << email
			else
				@task = @receiver.sent_tasks.build task_params
				@task.sender_id = @sender.id
				@task.save
				@tasks << @task
			end
		end
		if bad_emails.empty?
			respond_with @task, location: "/api/sent_tasks"
		else
			respond_with bad_emails, status: :bad_request, location: "/api/sent_tasks"
		end
	end

	def index
		@user = User.where(email: params[:email]).first
		@tasks = @user.sent_tasks
		respond_with @tasks
	end

	def destroy
		@task = SentTask.find params[:id]
		@task.destroy
		respond_with @task, location: '/api/tasks'
	end

	private

		def task_params
			params.permit :description
		end
end
