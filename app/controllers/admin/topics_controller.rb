class Admin::TopicsController < Admin::BaseController

	def index
		@topics = Topic.all.includes(:user)
	end

	def show
		@topic = Topic.includes(comments: :user).find(params[:id])
	end

	def new
		@topic = Topic.new
		@topic_options = Topic.all.collect { |topic| [ topic.category.name, topic.category_id ] }.uniq
	end

	def create
		@topic = Topic.new(topic_params)
		@topic.user = current_user

		if @topic.save
			redirect_to admin_topics_path, notice: 'Topic created successfully'
		else
			render :new
		end
	end

	def edit
		@topic = Topic.includes(:category).find(params[:id])
		@topic_options = Topic.all.includes(:category).collect { |topic| [ topic.category.name, topic.category_id ] }.uniq
	end

	def update
		@topic = Topic.find_by_id(params)

		if @topic.update(topic_params)
			redirect_to admin_topics_path, notice: 'Topic updated successfully'
		else
			render :edit
		end
	end

	def destroy
		@topic = Topic.find_by_id(params)
		@topic.destroy
		redirect_to admin_topics_path
	end

	private

	def topic_params
		params.require(:topic).permit(:subject, :body, :category_id)
	end

end
