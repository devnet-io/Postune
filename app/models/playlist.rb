class Playlist < ActiveRecord::Base

	attr_accessible :name, :user_id

	# A playlist belongs to a user and has songs in it
	belongs_to :user

	has_many :playlist_song, :dependent => :delete_all
	has_one	:library, :dependent => :destroy

	# Validate the name of the playlist
	validates :name, 	:presence => true, 
						:length => { :maximum => 75 }
	
	def self.search(query)
		if query
			where("name LIKE ?", "%#{query}%") 
		else 
			scoped
		end
	end
	
end
