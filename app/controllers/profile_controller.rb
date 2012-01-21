class ProfileController < ApplicationController

	def new
		@title = "Home"
		if signed_in?
			redirect_to profile_index_path
		else
		
		end
	end
	
	def index
		@title = current_user
	end

end
