class App < ActiveRecord::Base
	has_many :messages
	validates_presence_of :app_title, :description
end
