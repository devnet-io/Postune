class SongsController < ApplicationController

	def index
		@songs = Song.all
		@song_count = Song.count
	end
	
	def new
	end

	def create
	end
	
	def show
		inf = Song.find(params[:id])
		@title = inf.title
		@song = inf
	end
	
end
