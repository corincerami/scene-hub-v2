class ShowsController < ApplicationController
  include Geokit::Geocoders

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @zip_code = params[:zip_code]
    params[:radius].nil? || params[:radius].empty? ? @radius = 25 : @radius = params[:radius]
    @genre = params[:genre]
    if @genre
      @shows = Show.search(@zip_code, @radius, @genre)
      @shows = Kaminari.paginate_array(@shows).page params[:page]
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
    @band = Band.find(params[:user][:bands])
    @show = @band.shows.build(show_params)
    if !params[:user][:bands].empty? && @show.save
      Follow.where(band: @band).each do |follow|
        ShowNotification.notification(follow, @show).deliver
      end
      flash[:notice] = "Show created!"
      redirect_to show_path(@show)
    else
      render "new"
    end
  end

  def edit
    @show = current_user.shows.find(params[:id])
    @venue = @show.venue
    @band = @show.band
  end

  def update
    @show = current_user.shows.find(params[:id])
    @band = @show.band
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
    @show = current_user.shows.find(params[:id])
    if @show.destroy
      flash[:notice] = "Show deleted!"
      redirect_to shows_path
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
end
