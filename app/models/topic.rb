class Topic < ActiveRecord::Base
	has_many :comments
	validates :subject, :body, presence: true
end
