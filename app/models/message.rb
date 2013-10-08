class Message < ActiveRecord::Base
	belongs_to :app
	validates :username, :format => {:with => /([A-Za-z0-9\-\_]+)/}
	validates_presence_of :app_id, :content, :username
	validates_length_of :content, :in => 1..160
	validates_length_of :username, :in => 3..60
end
