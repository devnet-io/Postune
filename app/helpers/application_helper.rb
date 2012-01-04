module ApplicationHelper 
	
	def title
		@base_title = "Postune"
		if @title.nil?
			@title = "#{@base_title} | Untitled Page"
		else
			@title = "#{@base_title} | #{@title}"
		end
	end

end
