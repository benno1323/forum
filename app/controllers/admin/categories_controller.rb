class Admin::CategoriesController < Admin::BaseController
	before_action :find_category, only: [:show, :edit, :update, :destroy]

	def index
		@categories = Category.all
	end

	def show
		@topics = Category.load_topics_desc(@category)
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(categories_params)
		@category.user = current_user

		if @category.save
			redirect_to admin_categories_path, notice: 'Category created successfully!'
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @category.update(categories_params)
			redirect_to admin_categories_path, notice: 'Category updated successfully!'
		else
			render :edit
		end
	end

	def destroy
		@category.destroy
		redirect_to admin_categories_path
	end

	private

	def categories_params
		params.require(:category).permit(:name)
	end

	def find_category
		@category = Category.find_by_id(params)
	end
end
