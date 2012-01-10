require 'net/http'

class Song < ActiveRecord::Base

	attr_accessible :title, :artist, :album, :url, :type, :user_id, :artwork, :service_id

	belongs_to :user
	belongs_to :service

	url_regex = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?([\/].*)?$)/ix

	validates :url,		:presence => true,
						:format => { :with => url_regex }

	def validate_url(submitted_url)
		
	end
	
	def get_service(submitted_url)
		if submitted_url.include? "youtube"
			return true
		else 
			return false
		end
	end

	private


end
