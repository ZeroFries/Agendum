class Api::SentTasksController < ApplicationController
	respond_to :json

	def create
		@sender = User.where(email: params[:sender_email]).first
		params[:emails].split(";").each do |email|
			email.strip!
			@receiver = User.where(email: email).first
			if @reciever.nil?
				respond_with @reciever, status: :bad_request # shuts down request as soon as a bad email comes up
			else
				@task = @reciever.tasks.build task_params
				@task.sender_id = @sender.id
				@task.save
			end
		end
		respond_with @sender
	end

	private

		def task_params
			params.permit :description
		end
end
