class FollowsController < ApplicationController
  def create
    @band = Band.find(params[:band_id])
    follow = Follow.new(band: @band, user: current_user)
    if follow.save
      flash[:motice] = "Now following #{@band.name}"
      redirect_to @band
    else
      render @band
    end
  end

  def destroy
    follow = Follow.find(params[:id])
    @band = follow.band
    if follow.destroy
      flash[:notice] = "No longer following #{@band.name}"
      redirect_to @band
    else
      render @band
    end
  end
end
