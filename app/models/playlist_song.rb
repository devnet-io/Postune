class PlaylistSong < ActiveRecord::Base
	
	attr_accessible :song_id, :position, :playlist_id, :title, :artist, :album
	
	belongs_to :playlist
	belongs_to :song

end
