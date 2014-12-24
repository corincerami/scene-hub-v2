# There's a good argument out there for having one class
# deal with objects of that class. It's especially important
# when you will have large apps and knowing what links to
# what becomes more important. You might want to think about
# stripping out Venue into its own controller to allow for
# that. In case you want to hear Thoughtbot people talk about
# it, check out this podcast: http://bikeshed.fm/1

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
    @user = current_user
  end

  def create
    @venue = Venue.find_or_create_by(venue_params)
    @show = Show.new(show_params)
    if @show.save && !params[:user][:bands].empty?
      @band = Band.find(params[:user][:bands])
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
    @band = @show.bands.first
    gig = Gig.find_by(show_id: @show.id, band_id: @band.id)
    gig.update(band_id: params[:user][:bands])
    @venue = @show.venue
    @venue.update(venue_params)
    @show.update(show_params)
    if @show.save
      flash[:notice] = "Show updated!"
      redirect_to show_path(@show)
    else
      render "edit"
    end
  end

  def destroy
    # right now, as a random user I was able to destroy
    # shows. You want to add a limit that only allows
    # the creator of a show to be able to delete it
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
