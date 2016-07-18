class Admin::DashboardController < Admin::BaseController
	def index
		@comments = Comment.recent
	end
end
