class PlayerController < ApplicationController
	
	before_filter :find_playlist, :only => [:show]
	before_filter :deny_access

	def index
		@title = current_user.name
		@playlist = current_user.playlist.first
		@playlist_first = @playlist.playlist_song.order("position")
	end

	def show
		@playlist_songs = @playlist.playlist_song.order("position")
		render :show, :layout => false
	end	

	private

		def find_playlist
			@playlist = Playlist.find(params[:id])
		end


end
