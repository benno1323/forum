class CategoriesController < ApplicationController
	before_action :find_category, only: :show
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@categories = Category.includes(:topics).all
	end

	def show
		@topics = Category.load_topics_desc(@category)
	end

	private

	def find_category
		@category = Category.find_by_id(params)
	end

	def category_params
		params.require(:category).permit(:name)
	end
end
