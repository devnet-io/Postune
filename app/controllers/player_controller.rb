class PlayerController < ApplicationController
	helper_method :sort_column, :sort_direction
	before_filter :find_playlist, :is_user?, :find_library, :only => [:show]
	before_filter :find_library, :only => [:index]
	before_filter :deny_access

	def index
		@title = current_user.name
		if current_user.playlist.count > 0
			@playlist = current_user.library.playlist
			@playlist_first = @playlist.playlist_song.order("#{sort_column} #{sort_direction}")
		else
			@playlist_first = nil
		end
	end

	def show
		@playlist_songs = @playlist.playlist_song.order("#{sort_column} #{sort_direction}")
		render :show, :layout => false
	end	

	private
		
		def sort_column
			(PlaylistSong.column_names.include? params[:sort]) ? params[:sort] : "position"
		end

		def sort_direction
			(params[:dir] == "asc" || params[:dir] == "desc") ? params[:dir] : "asc"	
		end

		def find_playlist
			@playlist = Playlist.find(params[:id])
		end

		def find_library
			@library = Library.find_by_user_id!(current_user.id)
		end

		def is_user?
			current_user == @playlist.user
		end

end
