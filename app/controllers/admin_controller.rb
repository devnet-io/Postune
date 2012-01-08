class AdminController < ApplicationController
	def index 
		@title = "Admin Main"
		@song_count = Song.count
		@user_count = User.count
		@playlist_count = Playlist.count
	end

end
