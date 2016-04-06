class CommentsController < ApplicationController

	def create
		@comment = Topic.build_topic_comment(params, comment_params)
		@comment.user = current_user

		if @comment.save
			redirect_to topic_path(@comment.topic_id)
		else
			render 'topics/show', notice: "Content can't be blank"
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:content)
	end
end
