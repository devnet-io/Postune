class PlayerController < ApplicationController
	helper_method :sort_column, :sort_direction
	before_filter :find_playlist, :is_user?, :only => [:show]
	before_filter :deny_access

	def index
		@title = current_user.name
		if current_user.playlist.count > 0
			@playlist = current_user.playlist.first!
			@playlist_first = @playlist.playlist_song.order("position")
		else
			@playlist_first = nil
		end
	end

	def show
		@playlist_songs = @playlist.playlist_song.order("position")
		render :show, :layout => false
	end	

	private
		
		def sort_column
			PlaylistSong.column_names.include? params[:sort] ? params[:sort] : "position"
		end

		def sort_direction
			%w[asc desc].include?(params[:dir]) ? params[:dir] : "asc"	
		end

		def find_playlist
			@playlist = Playlist.find(params[:id])
		end

		def is_user?
			current_user == @playlist.user
		end

end
