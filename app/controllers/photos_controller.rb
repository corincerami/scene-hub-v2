class PhotosController < ApplicationController
  def new
    @band = Band.find(params[:band_id])
    @photo = Photo.new
  end

  def create
    @band = Band.find(params[:band_id])
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
end
