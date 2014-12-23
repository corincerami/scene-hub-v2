class ShowsController < ApplicationController
  include Geokit::Geocoders

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @zip_code = params[:zip_code]
    @radius = params[:radius]
    @radius = 25 if @raidus.nil? || @radius.empty?
    if @zip_code
      @shows = Show.joins(:venue).within(@radius.to_i, origin: @zip_code)
    else
      @shows = Show.all
    end
  end

  def show
    @show = Show.find(params[:id])
  end

  def new
    @show = Show.new
    @venue = Venue.new
    @band = Band.new
  end

  def create
    @venue = Venue.find_or_create_by(venue_params)
    @band = Band.find_or_create_by(band_params)
    @show = Show.new(show_params)
    if @show.save
      @gig = Gig.create(band_id: @band.id, show_id: @show.id)
      flash[:notice] = "Show created!"
      redirect_to show_path(@show)
    else
      render "new"
    end
  end

  def edit
    @show = Show.find(params[:id])
    @venue = @show.venue
    @band = @show.bands.first
  end

  def update
    @show = Show.find(params[:id])
    @venue = @show.venue
    @venue.update(venue_params)
    @band = @show.bands.first
    @band.update(band_params)
    @show.update(show_params)
    if @show.save
      flash[:notice] = "Show updated!"
      redirect_to show_path(@show)
    else
      render "edit"
    end
  end

  def destroy
    @show = Show.find(params[:id])
    if @show.destroy
      flash[:notice] = "Show deleted!"
      redirect_to shows_path
    else
      render "show"
    end
  end

  private

  def show_params
    show_params = params.require(:show).permit(:show_date, :details)
    show_params[:venue_id] = @venue.id
    show_params
  end

  def band_params
    params.require(:bands).permit(:name)
  end

  def venue_params
    venue_params = params.require(:venue).permit(:name, :street_1, :street_2, :city, :state, :zip_code, :details)
    address = "#{params[:venue][:street_1]}, #{params[:venue][:city]}, #{params[:venue][:state]}"
    loc = MultiGeocoder.geocode(address)
    if loc.success
      venue_params[:lat] = loc.lat
      venue_params[:lng] = loc.lng
    end
    venue_params
  end
end
