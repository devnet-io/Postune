class PlayerController < ApplicationController
	
	before_filter :find_playlist, :only => [:show]
	before_filter :find_playlist_song, :only => [:change]
	before_filter :deny_access
  
	def change
		render 	:text => "changeSong('#{@playlist_song.song.external_id}', '#{@playlist_song.song.url}', #{@playlist_song.song.service.id}, #{@playlist_song.playlist.id}, #{@playlist_song.position})",
				:content_type => "text/javascript"
	end

	def index
		@title = current_user.name
		@first_playlist = current_user.playlist.first.playlist_song.order("position")
	end

	def show
		@playlist_songs = @playlist.playlist_song.order("position")
		render :show, :layout => false
	end	

	private
		def find_playlist_song
			@playlist_song = PlaylistSong.find(params[:id])
		end
		
		def find_playlist
			@playlist = Playlist.find(params[:id])
		end


end
