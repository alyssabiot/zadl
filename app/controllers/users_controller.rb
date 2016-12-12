class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    # Compte les events auquels participe le current user sans en être organisateur
    @booking = Booking.new
    @bookings_as_participant = @user.bookings.joins(:event).where("events.active = ? AND bookings.cancelled = ?", true, false)
    @bookings_cancelled =
  end

  private
  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

end
