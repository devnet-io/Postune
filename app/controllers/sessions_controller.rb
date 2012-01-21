class SessionsController < ApplicationController

	def new
		@title = "Login"
		if signed_in?
			redirect_to current_user
		else
			@user = User.new
		end
	end
	
	def destroy
		sign_out
		redirect_to root_path
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
