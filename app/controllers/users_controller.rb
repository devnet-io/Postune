class UsersController < ApplicationController

#	before_filter :deny_limited_access
	layout 'admin'
	
	def show
		inf = User.find(params[:id])
		@title = inf.name
		@user = inf
	end


	def index
		@title = "All Users"
		@users = User.paginate(:page => params[:page], :per_page => 10)
		@count = User.count
	end
	
	def new
		@title = "Register"
		@new_object = User.new
	end
	
	def create
		@new_object = User.new(params[:user])
		if @new_object.save
			flash[:notice] = "You have successfully registered!"
			redirect_to @new_object
		else
			@title = "Register"
			render 'new'
		end
	end
	
end
