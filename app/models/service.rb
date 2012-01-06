class Service < ActiveRecord::Base

	attr_accessible :name, :url, :icon

	belongs_to :song

end
