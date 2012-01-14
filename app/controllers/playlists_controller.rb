class PlaylistsController < ApplicationController

	before_filter :deny_access, :deny_limited_access
	before_filter :find_playlist, :only => [:show, :destroy, :edit, :update]
	before_filter :find_user, :only => [:create]
	layout 'admin'
	
	def index
		@title = "Playlists"
		@playlists = Playlist.all
	end

	def new
		@title = "New Playlist"
		@new_playlist = Playlist.new
	end
	
	def show
		@title = @playlist.name
		@playlist_songs = @playlist.playlist_song.order("position")
	end
	
	def create
		@new_playlist = Playlist.new(:name => params[:playlist][:name], :user_id => params[:user_id])
		if @new_playlist.save
			flash[:notice] = "Successfully Added Playlist"
			redirect_to playlists_path
		else
			@title = "New Playlist"
			render :action => 'new', :params => params[:user_id]
		end
	end
	
	def edit
		@title = "Edit '#{@playlist.name}'"
	end
	
	def update
		if @playlist.update_attributes(params[:playlist])
			flash[:notice] = "Successfully updated '#{@playlist.name}'"
			redirect_to playlists_path
		else
			@title = "Edit '#{@playlist.name}'"
			render edit_playlist_path(@playlist)
		end
	end
	
	def destroy
		@playlist.destroy
		flash[:notice] = "Deleted #{@playlist.name}"
		redirect_to playlists_path
	end
	
	private
		def find_playlist
			@playlist = Playlist.find(params[:id])
		end
		
		def find_user
			@user = User.find(params[:user_id])
		end
		
end
