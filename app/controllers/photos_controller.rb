class PhotosController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def new
    @band = current_user.bands.find(params[:band_id])
    @photo = Photo.new
  end

  def create
    @band = current_user.bands.find(params[:band_id])
    params[:photo] ? @photo = @band.photos.build(photo_params) : @photo = Photo.new
    if @photo.save
      flash[:notice] = 'Photo uploaded'
      redirect_to band_path(@band)
    else
      render :new
    end
  end

  def destroy
    @band = current_user.bands.find(params[:band_id])
    @photo = @band.photos.find(params[:id])
    if @photo.destroy
      flash[:notice] = 'Photo deleted'
      redirect_to band_path(@band)
    else
      render @band
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end
end
