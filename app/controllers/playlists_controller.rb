class PlaylistsController < ApplicationController

	def index
		inf = User.find(params[:user_id])
		@title = "#{inf.name}'s Playlists"
		@user = inf
	end

	def new
		@title = "New Playlist"
	end
	
	def show
		inf = User.find(params[:user_id]).playlist.find(params[:id])
		@title = inf.name
		@playlist = inf
		@playlist_songs = inf.playlist_song.order("position")
	end
	
	def create
	
	end
	
end
