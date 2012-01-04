class SessionsController < ApplicationController
	def new
	end
	
	def destroy
		@title = "Logout"
	end
	
	def create
		user = User.authenticate(params[:session][:name], params[:session][:unencrypted_password])
		if user.nil?
			flash.now[:error] = "Invalid Password or Username"
			@title = "Register"
			@user = User.new
			render "users/new"
		else
			# sign_in user
			redirect_to user
		end
	end
end
