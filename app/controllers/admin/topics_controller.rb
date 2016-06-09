class Admin::TopicsController < Admin::BaseController

	def index
		@topics = Topic.all
	end

end
