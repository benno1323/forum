class Admin::TopicsController < Admin::BaseController

	def index
		@category = Category.find_by_id(params)
		@topics = Topic.all
	end

end
