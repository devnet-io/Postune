class SongsController < ApplicationController

	before_filter :deny_access, :deny_limited_access	
	before_filter :find_song, :only => [:show]
	layout 'admin'
	
	def index
		@title = "Songs"
		@songs = Song.paginate(:page => params[:page], :per_page => 25)
		@song_count = Song.count
	end
	
	def show
		@title = @song.title
	end
	
	def edit
	
	end
	
	def update
	
	end
	
	def destroy
	
	end
	
	private
		def find_song
			@song = Song.find(params[:id])
		end
		
	
end
