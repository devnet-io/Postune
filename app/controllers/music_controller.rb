require 'net/http'
require 'open-uri'
class MusicController < ApplicationController

	before_filter :deny_access
	before_filter :find_playlist, :only => [:new, :edit, :search, :create]
	before_filter :format_query_string, :query_youtube, :process_youtube_data, :query_soundcloud, :process_soundcloud_data, :only => [:search]
	
	def new
		@new_song = Song.new
	end
	
	def show

	end

	def create
		@new_song = Song.new(
			:title => params[:song][:title], 
			:album => params[:song][:album], 
			:artist => params[:song][:artist], 
			:url => params[:song][:url], 
			:user_id => current_user.id, 
			:playlist_id => @playlist.id
		)
		
		if @new_song.save
			render 	:text => "alert('Success')",
					:content_type => "text/javascript"
		else
			render 'new'
		end
	end

	def edit

	end
	
	def search
		@new_song = Song.new
	end

	private
		def find_playlist
			@playlist = Playlist.find(params[:library_id])
		end

		# Format the query string so it is usable in the API calls
		def format_query_string
			@query = params[:search].strip! || params[:search]
			@query = @query.gsub " ", "+"
		end

		# Search the Youtube database for the search query
		def query_youtube
			data = open("http://gdata.youtube.com/feeds/api/videos?max-results=10&alt=json&q=#{@query}").read
			@json_1 = JSON.parse(data)
		end

		# Process the YouTube JSON data
		def process_youtube_data
			@processed_yt = Array.new
			@json_1["feed"]["entry"].each do |entry| 
				@processed_yt.push(
					{
						"title" => entry["title"]["$t"],
						"author" => entry["author"][0]["name"]["$t"],
						"url" => entry["link"][0]["href"],
						"artwork" => entry["media$group"]["media$thumbnail"][0]["url"],
					}
				)
			end
		end

		# Search the Soundcloud database for the search query
		def query_soundcloud
			soundcloud_client_id = "33f255a6f2a015cd2bf4c80dc37ebcf7"
			data = open("http://api.soundcloud.com/tracks.json?client_id=#{soundcloud_client_id}&q=#{@query}").read
			@json_2 = JSON.parse(data)	
		end

		# Process the Soundcloud JSON data
		def process_soundcloud_data
			@processed_sc = Array.new
			# Limit Bug in Soundcloud API
			count = 0
			@json_2.each do |entry|
				if count < 10
					@processed_sc.push(
						{
							"title" => entry["title"],
							"author" => entry["user"]["username"],
							"url" => entry["permalink_url"],
							"artwork" => entry["artwork_url"] || entry["user"]["avatar_url"],
						}
					)
				end
				count+=1
			end
		end

end
