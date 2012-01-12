module SessionsHelper

	def sign_in(user)
		cookies.permanent.signed[:remember_token] = [user.id]
		self.current_user = user
	end
	
	def current_user=(user)
		@current_user = user
	end
	
	def current_user
		@current_user ||= User.find_by_id(remember_token)
	end
	
	def signed_in?
		!current_user.nil?
	end
	
	def admin?
		current_user.group.permission_level >= Group.find_by_name("Admin").permission_level 
	end

	private
	
		def remember_token
			cookies.signed[:remember_token] || [nil]
		end
		
end
