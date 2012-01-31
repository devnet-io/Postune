# TODO
# - Make the external id match an id that is given by the api of the website instead of a split [DONE]
#	- Clean up this code
# - Finish URL Validation
#	- Add a way to check if the YouTube video is embeddable
# - Fix the find artist method
# - Make the search look for artist and albums in addition to title
# - Modify the way the soundcloud ids work (Use a url as the id instead)
require 'net/http'
require 'open-uri'

class Song < ActiveRecord::Base
	attr_accessor :title, :artist, :album, :playlist_id
	attr_accessible :url, :type, :user_id, :artwork, :service_id, :external_id, :title, :artist, :album, :playlist_id

	belongs_to :user
	belongs_to :service
	
	has_many :playlist_song, :dependent => :delete_all
	
	# Regular Expression for validating an URL/URI
	# chrisbloom7 from 'https://gist.github.com/948880#file_environment.rb'
	
	url_regex 				= /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?([\/].*)?$)/ix
	
	# General validation for fields

	validates :url,				:presence => true,
								:format => { :with => url_regex }
	validates :title,			:presence => true,
								:length => { :maximum => 125 }
	validates :artist,			:length => { :maximum => 75 }
	validates :album, 			:length => { :maximum => 75 }
	validates_presence_of 		:user_id
	
	# Initiate before saving
						
	before_save :init
	after_create :create_assoc_playlist_song

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
			(@@results["artwork_url"].nil?) ? @@results["user"]["avatar_url"] : @@results["artwork_url"].gsub("large.jpg", "t300x300.jpg")
		end
	end

	# Create an associated playlist song for the song, and also add it to the user's library playlist
	def create_assoc_playlist_song
		last_playlist_song = PlaylistSong.where("playlist_id = #{playlist_id}").order("position").last
		last_position = (last_playlist_song == nil) ? 0 : last_playlist_song.position	
		PlaylistSong.create!(:song_id => id, :playlist_id => playlist_id, :position => (last_position + 1), :title => title, :artist => artist, :album => album)
		library = Library.find_by_user_id!(user_id).playlist.id
		last_library_song = PlaylistSong.where("playlist_id = #{library}").order("position").last
		last_library_position = (last_library_song == nil) ? 0 : last_library_song.position
		PlaylistSong.create!(:song_id => id, :playlist_id => library, :position => (last_library_position + 1), :title => title, :artist => artist, :album => album)
	end
			
	# Allows to search for a song based on title
	def self.search(query)
		if query
			where("url LIKE ?", "%#{query}%") 
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
			
			self.artwork 		||= find_artwork		end


end
