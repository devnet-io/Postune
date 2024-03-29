class AdminController < ApplicationController

	include AdminHelper

	before_filter :deny_access, :deny_limited_access
	layout 'admin'
	
	def index 
		@title = "Admin Main #{params[:search]}"
		@song_count = Song.count
		@user_count = User.count
		@playlist_count = Playlist.count
		@group_count = Group.count
		
		search(params[:search])
	end

end
