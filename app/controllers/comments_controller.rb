class CommentsController < ApplicationController

	def create
		load_topic
		build_comment

		if @comment.save
			redirect_to @topic
		else
			render 'topics/show'
		end
	end

	private

	def load_topic
		@topic = Topic.find(params[:topic_id])
	end

	def build_comment
		@comment = @topic.comments.build(comment_params)
	end

	def comment_params
		params.require(:comment).permit(:content)
	end
end
