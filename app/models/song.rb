require 'net/http'

class Song < ActiveRecord::Base

	attr_accessible :title, :artist, :album, :url, :type, :user_id, :artwork, :service_id, :external_id

	belongs_to :user
	belongs_to :service
	
	# Regular Expression for validating an URL/URI
	# chrisbloom7 from 'https://gist.github.com/948880#file_environment.rb'
	
	url_regex = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?([\/].*)?$)/ix

	# General validation for fields

	validates :url,			:presence => true,
							:format => { :with => url_regex }
	validates :title,		:presence => true,
							:length => { :maximum => 125 }
	validates :artist,		:length => { :maximum => 75 }
	validates :album, 		:length => { :maximum => 75 }
#	validates :service_id,	:presence => true
#	validates :external_id, :presence => true 
	
	# Initiate before saving
						
	before_save :init
	
	# Code modified from 'https://gist.github.com/948880#file_environment.rb'
	# Validates the response code of a submitted url
	
	def validate_url(submitted_url)
		response = Net::HTTP.get_response(URI.parse(submitted_url))
		return response
	end
	
	# Assigns a service id and obtains an external ID based on the service id
	
	def get_service(submitted_url)
		if submitted_url.include? "youtube"
			return true
		else 
			return false
		end
	end

	private
	
		# Get the proper service and further validate the URL and extract the external ID
		
		def init
		end


end
