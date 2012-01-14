class GroupsController < ApplicationController

	before_filter :deny_access, :deny_limited_access
	before_filter :find_group, :only => [:show]
	layout 'admin'
	
	def new
		@title = "New Group"
	end
	
	def index
		@title = "Groups"
		@groups = Group.all
	end
	
	def show
		@title = @group.name
		@groups = User.where("#{:group_id} = #{@group.id}").paginate(:page => params[:page], :per_page => 25)
	end
	
	private
		def find_group
			@group = Group.find(params[:id])
		end
	
end
