class Library < ActiveRecord::Base

	attr_accessible :playlist_id, :user_id

	belongs_to :user, 		:dependent => :destroy
	belongs_to :playlist, 	:dependent => :destroy
	
end
