class SessionsController < ApplicationController

	def new
		@title = "Login"
		@user = User.new
	end
	
	def destroy
		@title = "Logout"
	end
	
	def create
		user = User.authenticate(params[:session][:name], params[:session][:unencrypted_password])
		if user.nil?
			flash.now[:error] = "Invalid Password or Username"
			@title = "Login"
			@user = User.new
			render "new"
		else
			sign_in user
			redirect_to user
		end
	end
	
end
