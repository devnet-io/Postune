class GroupsController < ApplicationController

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
	end
	
	private
		def find_group
			@group = Group.find(params[:id])
		end
	
end
