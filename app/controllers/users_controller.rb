class UsersController < ApplicationController
	
	def show
		inf = User.find(params[:id])
		@title = inf.name
		@user = inf
	end


	def index
		@title = "All Users"
		@users = User.all
		@count = User.count
	end
	
	def new
		@title = "Register"
		@user = User.new
	end
	
	def create
		@user = User.new(params[:user])
		if @user.save
			flash[:notice] = "You have successfully registered!"
			redirect_to @user
		else
			@title = "Register"
			render 'new'
		end
	end
	
end
