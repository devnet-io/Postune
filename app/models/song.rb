# TODO
# - Make the external id match an id that is given by the api of the website instead of a split [DONE]
#	- Clean up this code
# - Finish URL Validation
#	- Add a way to check if the YouTube video is embeddable
# - Fix the find artist method
# - Make the search look for artist and albums in addition to title

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
	
	@@results = Hash.new
	
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
	
	# Search Soundcloud to get info using the external id
	def search_soundcloud(query)
		soundcloud_client_id = "33f255a6f2a015cd2bf4c80dc37ebcf7"
		soundcloud_username = self.external_id.split("/")[0]
		soundcloud_permalink = self.external_id.split("/")[1]
		data = open("http://api.soundcloud.com/tracks.json?client_id=#{soundcloud_client_id}&q=#{soundcloud_permalink}").read
		soundcloud_results = JSON.parse(data)
		soundcloud_results.each do |result|
			if result["user"]["permalink"] == soundcloud_username && result["permalink"] == soundcloud_permalink
				@@results = result
			end
		end
		self.external_id = @@results["id"]
	end
	
	# Search Youtube to get info using the external id
	def search_youtube(query)
		data = open("http://gdata.youtube.com/feeds/api/videos?max-results=1&alt=json&q=#{query}").read
		@@results = JSON.parse(data)
	end

	def find_artwork
		if self.service_id == Service.find_by_name("YouTube").id
			@@results["feed"]["entry"][0]["media$group"]["media$thumbnail"][0]["url"]
		elsif self.service_id == Service.find_by_name("Soundcloud").id
			(@@results["artwork_url"].nil?) ? @@results["user"]["avatar_url"] : @@results["artwork_url"]
		end
	end
	
	def find_artist
		if self.service_id == Service.find_by_name("YouTube").id
			@@results["feed"]["entry"][0]["author"][0]["name"]["$t"]
		elsif self.service_id == Service.find_by_name("Soundcloud").id
			@@results["user"]["username"]
		end
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
			
			self.artwork 		||= find_artwork
			
			self.artist = (self.artist.empty?) ? find_artist : self.artist
		end


end
