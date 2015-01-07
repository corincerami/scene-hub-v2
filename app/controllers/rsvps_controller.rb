class RsvpsController < ApplicationController
  def create
    @show = Show.find(params[:show_id])
    @rsvp = @show.rsvps.build(user: current_user)
    if @rsvp.save
      flash[:notice] = "RSVPed successfully!"
      redirect_to show_path(@show)
    else
      render show_path(@show)
    end
  end

  def destroy
    rsvp = Rsvp.find(params[:id])
    @show = rsvp.show
    if rsvp.destroy
      flash[:notice] = "RSVP cancelled"
      redirect_to show_path(@show)
    else
      render show_path(@show)
    end
  end
end
