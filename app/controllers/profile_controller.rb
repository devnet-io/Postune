class ProfileController < ApplicationController
	
	before_filter :deny_access, :only => [:index]
		
	def index

	end

	def new
		@title = "Register"
		if signed_in?
			redirect_to player_index_path
		else
			@new_user = User.new
		end
	end
		
	def create
		@new_user = User.new(params[:user])
		if @new_user.save
			UserMailer.welcome_email(@new_user).deliver
			flash[:notice] = "You have successfully registered! You will be receiving an email with further instructions!"
			redirect_to login_path
		else
			@title = "Register"
			render 'new'
		end
	end
		
	def activate
		user = User.find_by_activation_code!(params[:code])
		if user.update_attributes!(:is_active => 1) 
			sign_in(user)
			redirect_to root_path
		else
			flash[:notice] = "Could not activate your user or user was already activated"
			redirect_to login_path
		end
	end

	private

end
