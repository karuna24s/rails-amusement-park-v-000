class RidesController < ApplicationController
  def create
    @ride = Ride.new(ride_params)
    @user = User.find_by(params[:user_id])
    if @ride.save
      flash[:notice] = @ride.take_ride
      redirect_to user_path(@user)
    end
  end

  private
  def ride_params
    params.require(:ride).permit(:user_id, :attraction_id)
  end

end
