class LibraryController < ApplicationController

	helper_method :sort_column, :sort_direction
	before_filter :deny_access
	before_filter :find_playlist, :is_user?, :check_sorted, :only => [:show, :destroy]
	before_filter :set_sort_dir, :only => [:show, :index, :create]
	before_filter :find_library, :only => [:index, :show, :destroy]
	
	def new
		@new_playlist = Playlist.new
	end
	
	def create
		@new_playlist = Playlist.new(:name => params[:playlist][:name], :user_id => current_user.id)
		if @new_playlist.save
			@playlist_songs = nil
			@playlist = @new_playlist
			render 'create.js'
		else
			render 	'new'
		end
	end
	
	def index
		@title = current_user.name
		@playlist = current_user.library.playlist
		get_songs_json_encode
	end

	def show
		get_songs_json_encode
	end	
	
	def destroy
		@destroyed = @playlist
		@playlist.destroy
		@playlist = @library.playlist
		get_songs_json_encode
		render 'destroy.js'
	end

	private
	
		def sort_column
			(PlaylistSong.column_names.include? params[:sort]) ? params[:sort] : "position"
		end

		def sort_direction
			(params[:dir] == "asc" || params[:dir] == "desc") ? params[:dir] : "asc"	
		end

		def set_sort_dir
			@sort = sort_column
			@dir = sort_direction
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

		def is_sorted?
			return sort_column != "position" || sort_direction == "desc"
		end	

		def check_sorted
			@sorted = is_sorted?
		end

		def get_songs_json_encode
			@playlist_songs = @playlist.playlist_song.order("#{sort_column} #{sort_direction}")
			@json = ActiveSupport::JSON.encode(@playlist_songs)
		end

end
