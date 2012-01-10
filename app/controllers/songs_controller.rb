class SongsController < ApplicationController

	before_filter :find_song, :only => [:show]

	def index
		@title = "Songs"
		@songs = Song.all
		@song_count = Song.count
	end
	
	def show
		@title = @song.title
	end
	
	private
		def find_song
			@song = Song.find(params[:id])
		end
		
	
end
