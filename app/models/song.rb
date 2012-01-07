class Song < ActiveRecord::Base

	attr_accessible :title, :artist, :album, :url, :type, :user_id, :artwork, :service_id

	belongs_to :user
	belongs_to :service

end
