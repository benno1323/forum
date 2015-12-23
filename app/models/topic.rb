class Topic < ActiveRecord::Base
	validates :subject, :body, presence: true
end
