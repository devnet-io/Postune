class Playlist < ActiveRecord::Base

	attr_accessible :name, :user_id

	# A playlist belongs to a user and has songs in it
	belongs_to :user
	
	has_many :playlist_song
	 
	# Validate the name of the playlist
	validates :name, :presence => true

end
