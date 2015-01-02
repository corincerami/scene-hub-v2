class PhotosController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def new
    @band = Band.find(params[:band_id])
    @photo = Photo.new
    if !correct_user?
      flash[:error] = "You don't have permission to do that"
      redirect_to band_path(@band)
    end
  end

  def create
    @band = Band.find(params[:band_id])
    if !correct_user?
      flash[:error] = "You don't have permission to do that"
      redirect_to band_path(@band)
    end
    params[:photo] ? @photo = @band.photos.build(photo_params) : @photo = Photo.new
    if @photo.save
      flash[:notice] = "Photo uploaded"
      redirect_to band_path(@band)
    else
      render :new
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end

  def correct_user?
    current_user == @band.user
  end
end
