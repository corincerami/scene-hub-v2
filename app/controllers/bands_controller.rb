class BandsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit,
                                            :update, :destroy]

  def show
    @band = Band.find(params[:id])
    @band_post = BandPost.new
    @geojson = @band.geojson
    respond_to do |format|
      format.html
      format.json { render json: @geojson }
    end
  end

  def new
    @band = Band.new
    @genre = GenreList.new
  end

  def create
    @user = User.find(current_user.id)
    @band = current_user.bands.build(band_params)
    if @band.save
      @genre = GenreList.new(genre_list_params)
      @genre.band = @band
      if @genre.save
        flash[:notice] = 'Band created!'
        redirect_to band_path(@band)
      else
        @band.destroy
        render :new
      end
    else
      @genre = GenreList.create(genre_list_params)
      render :new
    end
  end

  def edit
    @band = current_user.bands.find(params[:id])
    @genre = @band.genre_list
  end

  def update
    @band = current_user.bands.find(params[:id])
    @genre = @band.genre_list
    if @band.update(band_params) && @genre.update(genre_list_params)
      flash[:notice] = 'Band updated!'
      redirect_to band_path(@band)
    else
      render :edit
    end
  end

  def destroy
    @band = current_user.bands.find(params[:id])
    if @band.destroy
      flash[:notice] = 'Band deleted!'
      redirect_to user_path(current_user)
    else
      render :show
    end
  end

  private

  def band_params
    params.require(:band).permit(:name, :spotify_uri)
  end

  def genre_list_params
    params.require(:genre_list).permit(:genre)
  end
end
