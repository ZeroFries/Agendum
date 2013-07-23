class Api::UsersController < ApplicationController
	respond_to :json

	def index
		@users = User.all
		respond_with @users
	end

	def show
	end

	def new
		@user = User.new
	end

	def create
		@user = User.create user_params
		respond_with @user, location: root_path
	end

	private

		def user_params
			params.permit :email, :password, :password_confirmation
		end
end
