class PlaylistSongsController < ApplicationController

	before_filter :deny_access, :deny_limited_access
	before_filter :find_playlist, :only => [:show, :new, :create]
	layout 'admin'

	def new
		@title = "New Playlist Song"
		@new_song = Song.new
	end

	def show
		@playlist_song = @playlist.playlist_song.find(params[:id])
		@title = @playlist_song.song.title
		@song = @playlist_song.song
	end
	
	def create
		@new_song = Song.new(:title => params[:song][:title], :album => params[:song][:album], :artist => params[:song][:artist], :url => params[:song][:url], :user_id => @playlist.user.id)
		
		if @new_song.save
			just_created = Song.where("#{:user_id} = #{@playlist.user.id} AND #{:url} = '#{params[:song][:url]}'").last
			last_playlist_song = PlaylistSong.where("#{:playlist_id} = #{params[:playlist_id]}").order("position asc").last
			last_position = (last_playlist_song == nil) ? 0 : last_playlist_song.position
			
			@new_playlist_song = PlaylistSong.new(:song_id => just_created.id, :playlist_id => params[:playlist_id], :position => (last_position + 1))
			
			if @new_playlist_song.save
				flash[:notice] = "You have added a song!"
				redirect_to @playlist
			else
				@title = "New Playlist Song"
				render :action => 'new'
			end
			
		else
			@title = "New Playlist Song"
			render :action => 'new'
		end
	end
	
	private
		def find_playlist
			@playlist = Playlist.find(params[:playlist_id])
		end

end
