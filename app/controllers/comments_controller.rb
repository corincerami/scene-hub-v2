class CommentsController < ApplicationController
	def create
		@show = Show.find(params[:show_id])
		@comment = Comment.create(comment_params)
		if @comment.save
			flash[:notice] = "Comment posted!"
			redirect_to show_path(@show)
		else
			render show_path(@show)
		end
	end

	private

	def comment_params
		comment_params = params.require(:comment).permit(:body, :title)
		comment_params[:show_id] = params[:show_id]
		comment_params
	end
end