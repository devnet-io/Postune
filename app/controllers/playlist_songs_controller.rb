class PlaylistSongsController < ApplicationController

	before_filter :deny_access, :deny_limited_access
	before_filter :find_playlist, :only => [:new, :create]
	layout 'admin'

	def new
		@title = "New Playlist Song"
		@new_song = Song.new
	end

	def create
		@new_song = Song.new(:title => params[:song][:title], :album => params[:song][:album], :artist => params[:song][:artist], :url => params[:song][:url], :user_id => @playlist.user.id)
		
		if @new_song.save
#			just_created = Song.where("#{:user_id} = #{@playlist.user.id} AND #{:url} = '#{params[:song][:url]}'").last
			last_playlist_song = PlaylistSong.where("#{:playlist_id} = #{params[:playlist_id]}").order("position asc").last
			last_position = (last_playlist_song == nil) ? 0 : last_playlist_song.position
			
			@new_playlist_song = PlaylistSong.new(:song_id => @new_song.id, :playlist_id => params[:playlist_id], :position => (last_position + 1))
			
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

	def edit
		# When you update, you can't move it to a position that is past the last item. Every item less or equal moves down one
	end
	
	def update
	
	end
	
	def destroy
		# When you destroy, you have to update the position of everything with a greater position down one
	end
	
	private
		def find_playlist
			@playlist = Playlist.find(params[:playlist_id])
		end

end
