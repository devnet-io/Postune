class LibraryController < ApplicationController

	before_filter :deny_access
	
	def new
		@new_playlist = Playlist.new
		render :new, :layout => false
	end
	
	def create
		@new_playlist = Playlist.new(:name => params[:playlist][:name], :user_id => current_user.id)
		if @new_playlist.save
			render 	:text => "appendPlaylists(#{@new_playlist.id}, '#{player_path(@new_playlist)}', '#{@new_playlist.name}')",
					:content_type => "text/javascript"
		else
			render 	:new, :layout => false
		end
	end
	
	def index
		render :index, :layout => false
	end
	
	private
		

end
