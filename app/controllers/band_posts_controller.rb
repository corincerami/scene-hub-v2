class BandPostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit,
                                            :update, :destroy]

  def new
  end

  def create
    @band = current_user.bands.find(params[:band_id])
    @band_post = @band.band_posts.build(band_post_params)
    if @band_post.save
      flash[:notice] = 'Status update posted!'
      redirect_to band_path(@band)
    else
      render :new
    end
  end

  def edit
    @band = current_user.bands.find(params[:band_id])
    @band_post = @band.band_posts.find(params[:id])
  end

  def update
    @band = current_user.bands.find(params[:band_id])
    @band_post = @band.band_posts.find(params[:id])
    if @band_post.update(band_post_params)
      flash[:notice] = 'Status updated!'
      redirect_to band_path(@band)
    else
      render :edit
    end
  end

  def destroy
    @band = current_user.bands.find(params[:band_id])
    @band_post = @band.band_posts.find(params[:id])
    if @band_post.destroy
      flash[:notice] = 'Status deleted!'
      redirect_to band_path(@band)
    else
      render @band
    end
  end

  private

  def band_post_params
    params.require(:band_post).permit(:title, :content)
  end
end
