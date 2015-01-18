class BandsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

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
    @genres = GenreList.new
  end

  def create
    @user = User.find(current_user.id)
    @band = current_user.bands.build(band_params)
    if @band.save
      @genres = GenreList.new(genre_list_params)
      if @genres.save
        flash[:notice] = "Band created!"
        redirect_to band_path(@band)
      else
        @band.destroy
        render :new
      end
    else
      @genres = GenreList.create(genre_list_params)
      render :new
    end
  end

  def edit
    @band = current_user.bands.find(params[:id])
    @genres = @band.genre_list
  end

  def update
    @band = current_user.bands.find(params[:id])
    @genres = @band.genre_list
    if @band.update(band_params)
      if @genres.update(genre_list_params)
        flash[:notice] = "Band updated!"
        redirect_to band_path(@band)
      else
        render :edit
      end
    else
      render :edit
    end
  end

  def destroy
    @band = current_user.bands.find(params[:id])
    if @band.destroy
      flash[:notice] = "Band deleted!"
      redirect_to user_path(current_user)
    else
      render :show
    end
  end

  private

  def band_params
    band_params = params.require(:band).permit(:name, :spotify_uri)
  end

  def genre_list_params
    genres = params.require(:genre_list)[:genres].split(", ")
    genres.map! { |genre| genre.downcase }
    genre_params = Hash.new
    genre_params[:genres] = genres
    genre_params[:band_id] = @band.id
    genre_params
  end
end
