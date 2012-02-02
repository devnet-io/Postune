class ChangeController < ApplicationController
	
	before_filter :find_playlist_song, :only => [:show]
	before_filter :deny_access
	
	def show
	end
	
	private 
		def find_playlist_song
			if params[:sort].nil? 
				@playlist_song = PlaylistSong.where("#{:playlist_id} = #{params[:id]} AND #{:position} = #{params[:song]}").limit(1)[0]
			end
		end

end
