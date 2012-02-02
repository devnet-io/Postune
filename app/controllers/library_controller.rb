class LibraryController < ApplicationController

	before_filter :deny_access
	
	def new
		@new_playlist = Playlist.new
	end
	
	def create
		# Edit This
		@new_playlist = Playlist.new(:name => params[:playlist][:name], :user_id => current_user.id)
		if @new_playlist.save
			render 'create.js'
		else
			render 	'new'
		end
	end
	
	def index
		
	end
	
	private
		

end
