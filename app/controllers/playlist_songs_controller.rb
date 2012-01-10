class PlaylistSongsController < ApplicationController

	before_filter :find_user_playlist, :only => [:show]

	def index
	end

	def new
		@title = "New Playlist Song"
		@new_object = Song.new
	end

	def show
		@title = @playlist_song.song.title
		@song = @playlist_song.song
	end
	
	def create
		@new_object = Song.new(:title => params[:song][:title], :album => params[:song][:album], :artist => params[:song][:artist], :url => params[:song][:url], :user_id => params[:user_id])
		
		if @new_object.save
			just_created = Song.where("#{:user_id} = #{params[:user_id]} AND #{:url} = '#{params[:song][:url]}'").last
			last_playlist_song = PlaylistSong.where("#{:playlist_id} = #{params[:playlist_id]}").order("position asc").last
			last_position = (last_playlist_song == nil) ? 1 : last_playlist_song.position
			@new_object = PlaylistSong.new(:song_id => just_created.id, :playlist_id => params[:playlist_id], :position => (last_position + 1))
			
			if @new_object.save
	#			flash[:notice] = "You have added a song to '#{@playlist}'"
				redirect_to user_playlist_path(params[:user_id], params[:playlist_id])
			else
				@title = "New Playlist Song"
				render :action => 'new', :params => [:user_id, :playlist_id]
			end
			
		else
			@title = "New Playlist Song"
			render :action => 'new', :params => [:user_id, :playlist_id]
		end
	end
	
	private
		def find_user_playlist
			@user = User.find(params[:user_id])
			@playlist = @user.playlist.find(params[:playlist_id])
			@playlist_song = @playlist.playlist_song.find(params[:id])
		end

end
