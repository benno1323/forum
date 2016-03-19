class TopicsController < ApplicationController
	before_action :set_topic, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:show]

	def index
		@topics = Topic.all
	end

	def show
	end

	def new
		find_category
		@topic = @category.topics.build
	end

	def edit
	end

	def create
		find_category
		@topic = @category.topics.build(topic_params)
		@topic.user = current_user

		if @topic.save
			redirect_to @topic
		else
			render :new
		end
	end

	def update
		find_category
		if @topic.update(topic_params)
			redirect_to @topic
		else
			render :edit
		end
	end

	def destroy
		@topic.destroy
		redirect_to topics_url
	end

	private

	def set_topic
		@topic = Topic.find(params[:id])
	end

	def topic_params
		params.require(:topic).permit(:subject, :body)
	end

	def find_category
		@category = Category.find(params[:category_id])
	end
end
