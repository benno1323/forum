class CommentsController < ApplicationController

	def create
		@topic = Topic.find(params[:topic_id])
		@comment = @topic.comments.build(comment_params)
		if @comment.save
			redirect_to @topic
		else
			render 'topics/show'
		end
	end

	private
		def comment_params
			params.require(:comment).permit(:content)
		end
end
