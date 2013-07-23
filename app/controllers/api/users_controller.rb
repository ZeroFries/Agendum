class Api::UsersController < ApplicationController
	def index
	end

	def show
	end

	def new
		@user = User.new
	end

	def create
		#if User.where(email: params[:user][:email]).include? @user
			# try logging in user
	end
end
