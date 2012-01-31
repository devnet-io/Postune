class MusicController < ApplicationController

	before_filter :deny_access
	before_filter :find_playlist, :only => [:create]
	
	def new
		@new_song = Song.new
		@playlist = Playlist.find(params[:library_id])
		render :new, :layout=> false
	end
	
	def create 
		@new_song = Song.new(:title => params[:song][:title], :album => params[:song][:album], :artist => params[:song][:artist], :url => params[:song][:url], :user_id => current_user.id, :playlist_id => @playlist.id)
		
		if @new_song.save
			render 	:text => "alert('Success')",
					:content_type => "text/javascript"
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
