class BandPostsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	def new
	end

	def create
		@band = Band.find(params[:band_id])
		@band_post = BandPost.new(band_posts_params)
		if !correct_user?
			flash[:error] = "You don't have permission to do that"
			redirect_to band_path(@band) and return
		end
		if @band_post.save
			flash[:notice] = "Status update posted!"
			redirect_to band_path(@band)
		else
			render "new"
		end
	end

	private

	def band_posts_params
		band_post_params = params.require(:band_post).permit(:title, :content)
		band_post_params[:band_id] = params[:band_id]
		band_post_params
	end

	def correct_user?
    	@band = Band.find(params[:band_id])
    	current_user == @band.user
  	end
end