class ShowsController < ApplicationController
  include Geokit::Geocoders

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @zip_code = params[:zip_code]
    @radius = params[:radius]
    @radius = 25 if @radius.nil? || @radius.empty?
    @genre = params[:genre]
    if @genre
      @shows = Show.search(@zip_code, @radius, @genre)
      @shows = Kaminari.paginate_array(@shows).page(params[:page]) if @shows
    else
      @shows = Show.search(@zip_code, @radius, @genre).page params[:page]
    end
  end

  def show
    @show = Show.find(params[:id])
    @comment = Comment.new
    @rsvp = current_user.rsvps.find_by(show: @show) if signed_in?
  end

  def new
    @show = Show.new
    @venue = Venue.new
    @user = current_user
  end

  def create
    @venue = Venue.find_or_create_by(venue_params)
    @show = Show.new(show_params)
    if !params[:user][:bands].empty? && @show.save
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
    if !correct_user?
      flash[:error] = "You don't have permission to do that."
      redirect_to show_path(@show)
    end
  end

  def update
    @show = Show.find(params[:id])
    if !correct_user?
      flash[:error] = "You don't have permission to do that."
      redirect_to show_path(@show)
    end
    @band = @show.bands.first
    gig = Gig.find_by(show_id: @show.id, band_id: @band.id)
    gig.update(band_id: params[:user][:bands])
    @venue = @show.venue
    @venue.update(venue_params)
    if @show.update(show_params)
      flash[:notice] = "Show updated!"
      redirect_to show_path(@show)
    else
      render "edit"
    end
  end

  def destroy
    @show = Show.find(params[:id])
    if !correct_user?
      flash[:error] = "You don't have permission to do that."
    elsif @show.destroy
      flash[:notice] = "Show deleted!"
      redirect_to shows_path and return
    end
    render show_path(@show)
  end

  private

  def show_params
    show_params = params.require(:show).permit(:show_date, :details)
    show_params[:venue_id] = @venue.id
    show_params
  end

  def venue_params
    venue_params = params.require(:venue).permit(:name, :street_1, :street_2,
                                                 :city, :state, :zip_code, :details)
    address = "#{params[:venue][:street_1]}, #{params[:venue][:city]}, #{params[:venue][:state]}"
    loc = MultiGeocoder.geocode(address)
    if loc.success
      venue_params[:lat] = loc.lat
      venue_params[:lng] = loc.lng
    end
    venue_params
  end

  def correct_user?
    current_user == @show.bands.first.user
  end
end
