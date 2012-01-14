class UsersController < ApplicationController
	
	# Accessible only by admin
	before_filter :deny_limited_access
	before_filter :deny_access
	
	before_filter :find_user, :only => [:show, :edit, :update, :destroy]
	
	layout 'admin'
	
	def show
		@title = @user.name
	end


	def index
		@title = "All Users"
		@users = User.paginate(:page => params[:page], :per_page => 10)
		@count = User.count
	end
	
	def new
		@title = "Register"
		@new_user = User.new
	end
	
	def create
		@new_user = User.new(params[:user])
		if @new_user.save
			flash[:notice] = "You have successfully registered!"
			redirect_to @new_user
		else
			@title = "Register"
			render 'new'
		end
	end
	
	def edit
		@title = "Edit '#{@user.name}'"
		@groups = Group.all
	end
	
	def update
		# Check if the password field is blank to see if validation should occur
		@user.updating_password = (params[:user][:unencrypted_password].blank? && params[:user][:unencrypted_password_confirmation].blank?) ? false : true
		
		if @user.update_attributes(params[:user])
			flash[:success] = "Updated #{@user.name}'s settings."
			redirect_to @user
		else
			@title = "Edit '#{@user.name}'"
			@groups = Group.all
			render 'edit'
		end
	end
	
	def destroy
		if @user.destroy
			flash[:success] = "Deleted #{@user.name}"
			redirect_to users_path 
		else
			@title = @user.name
			render @user
		end
	end
	
	private
	
		def find_user
			@user = User.find(params[:id])
		end
	
end
