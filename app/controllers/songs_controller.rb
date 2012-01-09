class SongsController < ApplicationController

	before_filter :find_song, :only => [:new, :show, :create]

	def index
		@songs = Song.all
		@song_count = Song.count
	end
	
	def new
	end

	def create
	end
	
	def show
		@title = @song.title
	end
	
	private
		def find_song
			@song = Song.find(params[:id])
		end
		
	
end
