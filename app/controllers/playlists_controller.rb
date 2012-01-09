class PlaylistsController < ApplicationController

	before_filter :find_user

	def index
		@title = "#{@user.name}'s Playlists"
	end

	def new
		@title = "New Playlist"
		@new_object = Playlist.new
	end
	
	def show
		@title = @user.name
		@playlist = @user.playlist.find(params[:id])
		@playlist_songs = @playlist.playlist_song.order("position")
	end
	
	def create
		@new_object = Playlist.new(:name => params[:playlist][:name], :user_id => params[:user_id])
		if @new_object.save
			flash[:notice] = "Successfully Added Playlist"
			redirect_to user_playlists_path(params[:user_id])
		else
			@title = "New Playlist"
			render :action => 'new', :params => params[:user_id]
		end
	end
	
	private
		def find_user
			@user = User.find(params[:user_id])
		end
	
end
