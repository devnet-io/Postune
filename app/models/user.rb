require 'digest'
class User < ActiveRecord::Base
	attr_accessor :unencrypted_password
	attr_accessible :name, :email, :unencrypted_password, :unencrypted_password_confirmation
	
	belongs_to :group
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates :name,  					:presence => true,
										:length => { :within => 3..50 },
										:uniqueness => { :case_sensitive => false }
	validates :email,					:presence => true,
										:format => { :with => email_regex },
										:uniqueness => { :case_sensitive => false }
	validates :unencrypted_password,	:presence => true,
										:confirmation => true,
										:length => { :within => 6..50 }
							
	before_save :init
	
	def self.authenticate(username, submitted_password)
		user = User.find_by_name(username)
		return nil if user.nil?
		return user if (user.password ==  user.make_salt("#{user.salt}#{submitted_password}"))
	end
		
	# Salt a given string	
	def make_salt(string)
		Digest::SHA2.hexdigest(string)
	end		
							
	private 
		# Initialize all the User values	
		def init
			self.is_active 			= 0
			self.group_id 			= 1
			self.salt 				= make_salt("#{Time.now.utc}**")
			self.activation_code 	= generate_activation_code
			self.password 			= generate_encrypted_password
		end	
			
		def generate_activation_code
			make_salt(self.email)
		end
		
		def generate_encrypted_password
			make_salt("#{self.salt}#{unencrypted_password}")
		end

end
