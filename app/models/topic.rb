class Topic < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	validates :subject, :body, presence: true
end
