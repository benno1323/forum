class Category < ActiveRecord::Base
	has_many :topics, dependent: :destroy
	belongs_to :user
	validates :name, :user_id, presence: true

	private

	def self.find_by_id(params)
		if params[:category_id]
			find(params[:category_id])
		else
			find(params[:id])
		end
	end

	def self.load_topics_desc(category)
		Category.includes(topics: :user).find(category.id).topics
	end

	def self.build_category_topic(params, topic_params)
		@category = Category.find_by_id(params)
		@category.topics.build(topic_params)
	end
end
