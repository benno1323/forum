class Topic < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	belongs_to :category
	validates :subject, :body, presence: true
end
