class Group < ActiveRecord::Base

	attr_accessible :name, :permission_level, :description
	
	has_many :users
	
end
