class CommentsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	def new
	end

	def create
		@show = Show.find(params[:show_id])
		@comment = @show.comments.build(comment_params)
		if @comment.save
			flash[:notice] = "Comment posted!"
			redirect_to show_path(@show)
		else
			render "new"
		end
	end

	def edit
		@show = Show.find(params[:show_id])
		@comment = current_user.comments.find(params[:id])
	end

	def update
		@show = Show.find(params[:show_id])
		@comment = current_user.comments.find(params[:id])
		if @comment.update(comment_params)
			flash[:notice] = 'Comment updated!'
			redirect_to show_path(@show)
		else
			render "edit"
		end
	end

	def destroy
		@show = Show.find(params[:show_id])
		@comment = current_user.comments.find(params[:id])
		if @comment.destroy
			flash[:notice] = "Comment deleted!"
			redirect_to show_path(@show)
		else
			render show_path(@show)
		end
	end

	private

	def comment_params
		comment_params = params.require(:comment).permit(:body, :title)
		comment_params[:user_id] = current_user.id
		comment_params
	end
end
