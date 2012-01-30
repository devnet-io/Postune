class MusicController < ApplicationController

	before_filter :deny_access
	before_filter :find_playlist, :only => [:create]
	
	def new
		@new_song = Song.new
		@playlist = Playlist.find(params[:library_id])
		render :new, :layout=> false
	end
	
	def create 
		@new_song = Song.new(:title => params[:song][:title], :album => params[:song][:album], :artist => params[:song][:artist], :url => params[:song][:url], :user_id => current_user.id)
		
		if @new_song.save
			just_created = Song.where("#{:user_id} = #{@playlist.user.id} AND #{:url} = '#{params[:song][:url]}'").last
			last_playlist_song = PlaylistSong.where("#{:playlist_id} = #{params[:library_id]}").order("position asc").last
			last_position = (last_playlist_song == nil) ? 0 : last_playlist_song.position
			
			@new_playlist_song = PlaylistSong.new(:song_id => just_created.id, :playlist_id => params[:library_id], :position => (last_position + 1))
			
			if @new_playlist_song.save
				render 	:text => "alert('Success')",
						:content_type => "text/javascript"
			else
				render 	:text => "alert('Failed to Save New Playlist Song')",
						:content_type => "text/javascript"
			end
			
		else
			render 	:text => "alert('Failed to Save')",
					:content_type => "text/javascript"
		end
	end
	
	private
		def find_playlist
			@playlist = Playlist.find(params[:library_id])
		end

end
