require 'net/http'
require 'open-uri'

class Song < ActiveRecord::Base

	attr_accessible :title, :artist, :album, :url, :type, :user_id, :artwork, :service_id, :external_id

	belongs_to :user
	belongs_to :service
	
	has_many :playlist_song, :dependent => :destroy
	
	# Regular Expression for validating an URL/URI
	# chrisbloom7 from 'https://gist.github.com/948880#file_environment.rb'
	
	url_regex 				= /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?([\/].*)?$)/ix
	
	# General validation for fields

	validates :url,			:presence => true,
							:format => { :with => url_regex }
	validates :title,		:presence => true,
							:length => { :maximum => 125 }
	validates :artist,		:length => { :maximum => 75 }
	validates :album, 		:length => { :maximum => 75 }
	validates_presence_of 	:user_id
	
	# Initiate before saving
						
	before_save :init
	
	# Code modified from 'https://gist.github.com/948880#file_environment.rb'
	# Validates the response code of a submitted url
	def validate_url(submitted_url)
		response = Net::HTTP.get_response(URI.parse(submitted_url))
		return response
	end

	def get_service(submitted_url)
		if submitted_url.include? "youtube"
			return Service.find_by_name("YouTube").id
		elsif submitted_url.include? "soundcloud"
			return Service.find_by_name("Soundcloud").id
		end
	end

	# (Basic id extracting implemented)
	def get_external(submitted_url)
		if self.service_id == Service.find_by_name("YouTube").id
			submitted_url.split("?v=")[1].split("&")[0]
		elsif self.service_id == Service.find_by_name("Soundcloud").id
			submitted_url.split(".com/")[1]
		end
	end
	
	def search_soundcloud(query)
		soundcloud_client_id = "33f255a6f2a015cd2bf4c80dc37ebcf7"
		data = open("http://api.soundcloud.com/tracks.json?client_id=#{soundcloud_client_id}&q=#{self.external_id}&limit=1").read
		result = JSON.parse(data)
		self.artwork = (result[0]["artwork_url"].nil?) ? result[0]["user"]["avatar_url"] : result[0]["artwork_url"]
	end
	
	def search_youtube(query)
		data = open("http://gdata.youtube.com/feeds/api/videos?max-results=1&alt=json&q=#{query}").read
		result = JSON.parse(data)
		self.artwork = result["feed"]["entry"][0]["media$group"]["media$thumbnail"][0]["url"]
	end
	
	# Allows to search for a song based on title
	def self.search(query)
		if query
			where("title LIKE ?", "%#{query}%") 
		else 
			scoped
		end
	end
	
	private
	
		# Get the proper service and further validate the URL and extract the external ID
		def init
			self.service_id 	||= get_service(self.url)
			self.external_id 	||= get_external(self.url)
			
			if self.service_id == Service.find_by_name("YouTube").id
				search_youtube(self.url)
			elsif self.service_id == Service.find_by_name("Soundcloud").id
				search_soundcloud(self.url)
			end
		end


end
