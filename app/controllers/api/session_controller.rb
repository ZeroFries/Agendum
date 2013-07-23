class Api::SessionController < ApplicationController
	respond_to :json

	def create
		@user = User.where(email: params[:email]).first
		if @user != nil
			@user.authenticate(params[:password])
			respond_with @user, location: root_path
		else
			respond_with @user, status: :unauthorized	, location: root_path
		end
	end

	def destroy
	end
end