class Admin::CommentsController < Admin::BaseController
	def index
		@comments = Comment.all
	end

	def show
		@comment = Comment.find(params[:id])
	end

	def new
		@comment = Comment.new
	end

	def edit
		@comment = Comment.find(params[:id])
	end

	def create
		find_topic
		@comment = @topic.comments.build(comment_params)
		@comment.user = current_user

		if @comment.save
			redirect_to admin_comments_path
		else
			render :new
		end
	end

	def update
		@comment = Comment.find(params[:id])
		if @comment.update(comment_params)
			redirect_to admin_comments_path
		else
			render :edit
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		redirect_to admin_comments_path
	end

	private

	def find_topic
		@topic = Topic.find(params[:topic_id])
	end

	def comment_params
		params.require(:comment).permit(:content, :topic_id)
	end
end