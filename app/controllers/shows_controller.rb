class ShowsController < ApplicationController
  def index
    @shows = Show.all
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

  def show
    @show = Show.find(params[:id])
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
    params.require(:venue).permit(:name, :street_1, :street_2, :city, :state, :zip_code, :details)
  end
end
