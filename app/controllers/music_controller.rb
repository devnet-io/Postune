class MusicController < ApplicationController

	before_filter :deny_access

	def new
		@new_song = Song.new
		render :new, :layout=> false
	end

end
