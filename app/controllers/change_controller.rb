class ChangeController < ApplicationController
	
	before_filter :find_playlist_song, :only => [:song]
	before_filter :deny_access
	
	def song 
		render 	:text => "changeSong('#{@playlist_song.song.external_id}', '#{@playlist_song.song.url}', #{@playlist_song.song.service.id}, #{@playlist_song.playlist.id}, #{@playlist_song.position})",
				:content_type => "text/javascript"	
	end
	
	private 
		def find_playlist_song
			@playlist_song = PlaylistSong.where("#{:playlist_id} = #{params[:player_id]} AND #{:position} = #{params[:id]}").limit(1)[0]
		end

end
