class ProfileController < ApplicationController

	def new
	
	end
	
	def index
		@title = current_user
	end

end
