class FollowsController < ApplicationController
  def create
    @band = Band.find(params[:band_id])
    follow = @band.follows.build(user: current_user)
    if follow.save
      flash[:motice] = "Now following #{@band.name}"
      redirect_to @band
    else
      render @band
    end
  end

  def destroy
    follow = current_user.follows.find(params[:id])
    @band = follow.band
    if follow.destroy
      flash[:notice] = "No longer following #{@band.name}"
      redirect_to @band
    else
      render @band
    end
  end
end
