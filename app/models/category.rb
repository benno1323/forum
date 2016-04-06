class Category < ActiveRecord::Base
	has_many :topics
	validates :name, presence: true

	private

	def self.find_by_id(params)
		if params[:category_id]
			find(params[:category_id])
		else
			find(params[:id])
		end
	end

	def self.find_topics_desc(params)
		@category = find_by_id(params)
		@category.topics.order(created_at: :desc)
	end

	def self.build_category_topic(params, topic_params)
		@category = Category.find_by_id(params)
		@category.topics.build(topic_params)
	end
end
