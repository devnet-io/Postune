class SongsController < ApplicationController

	before_filter :deny_access, :deny_limited_access	
	before_filter :find_song, :only => [:show, :destroy, :edit, :update]
	layout 'admin'
	
	def index
		@title = "Songs"
		@songs = Song.paginate(:page => params[:page], :per_page => 25)
		@song_count = Song.count
	end
	
	def show
		@title = @song.title
	end
	
	def edit
		@title = "Edit Song"
	end
	
	def update
		if @song.update_attributes(params[:song])
			flash[:success] = "Successfully edited '#{@song.title}'"
			redirect_to songs_path
		else
			@title = "Edit '#{@song.title}'"
			render 'edit'
		end
	end
	
	def destroy
		@song.destroy
		flash[:notice] = "Successfully deleted #{@song.title}"
		redirect_to songs_path
	end
	
	private
		def find_song
			@song = Song.find(params[:id])
		end
		
	
end
