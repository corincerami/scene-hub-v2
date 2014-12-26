class CommentsController < ApplicationController
	def new
	end

	def create
		@show = Show.find(params[:show_id])
		@comment = Comment.create(comment_params)
		if @comment.save
			flash[:notice] = "Comment posted!"
			redirect_to show_path(@show)
		else
			render "new"
		end
	end

	def edit
		@show = Show.find(params[:show_id])
		@comment = Comment.find(params[:id])
	end

	def update
		@show = Show.find(params[:show_id])
		@comment = Comment.find(params[:id])
		@comment.update(comment_params)
		if @comment.save
			flash[:notice] = 'Comment updated!'
			redirect_to show_path(@show)
		else
			render "edit"
		end
	end

	private

	def comment_params
		comment_params = params.require(:comment).permit(:body, :title)
		comment_params[:show_id] = params[:show_id]
		comment_params
	end
end