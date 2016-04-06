class TopicsController < ApplicationController
	before_action :find_topic, only: [:show, :edit, :update, :destroy]
	before_action :find_category, only: [:new, :create, :update]
	before_action :authenticate_user!, except: [:show]

	def index
		@topics = Topic.all
	end

	def show
		@comment = @topic.comments.build
	end

	def new
		@topic = @category.topics.build
	end

	def edit
	end

	def create
		@topic = Category.build_category_topic(params, topic_params)
		@topic.user = current_user

		if @topic.save
			redirect_to @topic
		else
			render :new
		end
	end

	def update
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

	def find_topic
		@topic = Topic.find_by_id(params)
	end

	def topic_params
		params.require(:topic).permit(:subject, :body)
	end

	def find_category
		@category = Category.find_by_id(params)
	end
end
