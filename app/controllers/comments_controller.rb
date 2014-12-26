class CommentsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	
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
		if !correct_user?
			flash[:error] = "You don't have permission to do that"
			redirect_to show_path(@show)
		end
	end

	def update
		@show = Show.find(params[:show_id])
		@comment = Comment.find(params[:id])
		if !correct_user?
			flash[:error] = "You don't have permission to do that"
			redirect_to show_path(@show)
		end
		if @comment.update(comment_params)
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
		comment_params[:user_id] = current_user.id
		comment_params
	end

	def correct_user?
    @comment = Comment.find(params[:id])
    current_user == @comment.user
  end
end