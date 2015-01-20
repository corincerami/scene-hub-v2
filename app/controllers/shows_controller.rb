class ShowsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @zip_code = params[:zip_code]
    params[:radius].nil? || params[:radius].empty? ? @radius = 25 : @radius = params[:radius]
    @genre = params[:genre]
    @shows = Show.search(@zip_code, @radius, @genre).page params[:page]
  end

  def show
    @show = Show.find(params[:id])
    @comment = Comment.new
    @rsvp = current_user.rsvps.find_by(show: @show) if signed_in?
  end

  def new
    @show = Show.new
    @venue = Venue.new
  end

  def create
    @band = current_user.bands.find(params[:user][:bands])
    @show = @band.shows.build(show_params)
    @venue = Venue.find_or_create_by(venue_params)
    @show.venue = @venue
    if @show.save
      @show.mail_followers
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
    @show.venue.update(venue_params)
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
    else
      render show_path(@show)
    end
  end

  private

  def show_params
    show_params = params.require(:show).permit(:show_date, :details)
  end

  def venue_params
    venue_params = params.require(:venue).permit(:name, :street_1, :street_2,
                                                 :city, :state, :zip_code, :details)
    @show.geocode_venue(venue_params)
  end
end
