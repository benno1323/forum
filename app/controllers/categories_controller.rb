class CategoriesController < ApplicationController
	before_action :find_category, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@categories = Category.all
	end

	def show
		@topics = Category.find_topics_desc(params)
	end

	def new
		@category = Category.new
	end

	def edit
	end

	def create
		@category = Category.new(category_params)

		if @category.save
			redirect_to categories_url
		else
			render :new
		end
	end

	def update
		if @category.update(category_params)
			redirect_to @category
		else
			render :edit
		end
	end

	def destroy
		@category.destroy
		redirect_to categories_url
	end

	private

	def find_category
		@category = Category.find_by_id(params)
	end

	def category_params
		params.require(:category).permit(:name)
	end
end
