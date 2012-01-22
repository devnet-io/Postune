class ProfileController < ApplicationController

	before_filter :find_playlist, :only => [:show]

	def new
		@title = "Home"
		if signed_in?
			redirect_to profile_index_path
		else
		
		end
	end
	
	def index
		@title = current_user.name
		@first_playlist = current_user.playlist.first.playlist_song.order("position")
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
