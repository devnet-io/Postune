class Library < ActiveRecord::Base

	attr_accessible :playlist_id, :user_id

	belongs_to :user
	belongs_to :playlist
	
end
