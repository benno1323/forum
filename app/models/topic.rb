class Topic < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	belongs_to :category
	belongs_to :user
	validates :subject, :body, :user_id, presence: true

	private

	def self.find_by_id(params)
		if params[:topic_id]
			find(params[:topic_id])
		else
			find(params[:id])
		end
	end

	def self.build_topic_comment(params, comment_params)
		@topic = Topic.find_by_id(params)
		@topic.comments.build(comment_params)
	end

	def self.load_comments(topic)
		topic.comments.build
	end
end