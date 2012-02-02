module ApplicationHelper 
	
	def title
		@base_title = "Postune"
		if @title.nil?
			@title = "#{@base_title} | Untitled Page"
		else
			@title = "#{@base_title} | #{@title}"
		end
	end

	def sortable_column(column, controller, action, id, title = nil)
		title ||= column.titleize		
		class_sort = column == sort_column ? "sortable_column #{sort_direction}" : "sortable_column"
		direction  = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
		link_to title, {:controller => controller, :action => action, :id => id, :sort => column, :dir => direction}, :class => class_sort, :remote => true
	end

end
