class PlaylistSongsController < ApplicationController

	def index
	end

	def new
	end

	def show
		inf = User.find(params[:user_id]).playlist.find(params[:playlist_id]).playlist_song.find(params[:id]).song
		@title = inf.title
		@song = inf
	end
	
	def create
	end

end
