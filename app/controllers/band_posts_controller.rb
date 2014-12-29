class BandPostsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	def create
		@band = Band.find(params[:band_id])
		@post = BandPost.new(band_posts_params)
		if @post.save
			flash[:notice] = "Status update posted!"
			redirect_to band_path(@band)
		else
			render band_path(@band)
		end
	end

	private

	def band_posts_params
		band_post_params = params.require(:band_post).permit(:title, :content)
		band_post_params[:band_id] = params[:band_id]
		band_post_params
	end
end