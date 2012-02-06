class Service < ActiveRecord::Base

	attr_accessible :name, :url, :icon

	has_many :song

end
