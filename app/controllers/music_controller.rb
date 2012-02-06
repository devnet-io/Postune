require 'net/http'
require 'open-uri'
class MusicController < ApplicationController

	before_filter :deny_access
	before_filter :find_playlist, :only => [:new, :edit, :search, :create]
	before_filter :format_query_string, :query_youtube, :process_youtube_data, :query_soundcloud, :only => [:search]
	
	def new
		@new_song = Song.new
	end
	
	def show

	end

	def create
		@new_song = Song.new(:title => params[:song][:title], :album => params[:song][:album], :artist => params[:song][:artist], :url => params[:song][:url], :user_id => current_user.id, :playlist_id => @playlist.id)
		
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

		def format_query_string
			@query = params[:search].strip! || params[:search]
			@query = @query.gsub " ", "+"
		end

		def query_youtube
			data = open("http://gdata.youtube.com/feeds/api/videos?max-results=10&alt=json&q=#{@query}").read
			@json_1 = JSON.parse(data)
		end

		def process_youtube_data
			@processed = Array.new
			@json_1["feed"]["entry"].each do |entry| 
				@processed.push(
					{
						"title" => entry["title"]["$t"],
						"author" => entry["author"][0]["name"]["$t"],
						"url" => entry["link"][0]["href"],
						"artwork" => entry["media$group"]["media$thumbnail"][0]["url"],
					}
				)
			end
		end

		def query_soundcloud
			soundcloud_client_id = "33f255a6f2a015cd2bf4c80dc37ebcf7"
			data = open("http://api.soundcloud.com/tracks.json?client_id=#{soundcloud_client_id}&q=#{@query}").read
			@json_2 = data	
		end

end
