module AdminHelper
	
	def search(query) 	
		@results = Hash["Users", User.search(query), "Playlists", Playlist.search(query), "Songs", Song.search(query)]
	end
	
end
