class LibraryController < ApplicationController

	before_filter :deny_access
	
	def new
		@new_playlist = Playlist.new
		render :new, :layout => false
	end
	
	def create
		render 	:text => "alert('Created!')",
				:content_type => "text/javascript"
	end
	
	def index
		render :index, :layout => false
	end
	
	private
		

end
