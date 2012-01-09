class PlaylistSongsController < ApplicationController

	before_filter :find_user_playlist

	def index
	end

	def new
	end

	def show
		@title = @playlist_song.song.title
		@song = @playlist_song.song
	end
	
	def create
	end
	
	private
		def find_user_playlist
			@user = User.find(params[:user_id])
			@playlist = @user.playlist.find(params[:playlist_id])
			@playlist_song = @playlist.playlist_song.find(params[:id])
		end

end
