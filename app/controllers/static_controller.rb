class StaticController < ApplicationController
	respond_to :json, :html

	def home
		@user = User.new
		respond_to do |format|
			format.html
			format.json {
				respond_with @user
			}
		end
	end
end
