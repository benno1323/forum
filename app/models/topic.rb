class Topic < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	belongs_to :category
	belongs_to :user
	validates :subject, :body, :user_id, presence: true
end
