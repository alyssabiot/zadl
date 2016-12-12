class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @booking = Booking.new
    # Tous les bookings en cours de l'user (yc. lorsqu'il organise ou lorsqu'il est en liste d'attente)
    @all_bookings_active = @user.bookings.joins(:event).where("events.active = ? AND bookings.cancelled = ?", true, false)
    # Tous les bookings en cours de l'user à venir
    @bookings_active_to_come = @all_bookings_active.select do |booking|
      booking.starts_at >= Date.now
    end
    # Tous les bookings en cours de l'user passés
    @bookings_active_past = @all_bookings_active.select do |booking|
      booking.starts_at < Date.now
    end
    # Tous les bookings de l'user où l'event a été annulé
    @bookings_event_cancelled = @user.bookings.joins(:event).where("events.active = ?", false)
    # Tous les bookings de l'user où il a annulé sa participation
    @bookings_cancelled = @user.bookings.joins(:event).where("events.active = ? AND bookings.cancelled = ?", true, true)
    # Tous les bookings non archivés
    @bookings_not_archived = @bookings_active_to_come
    # Tous les bookings archivés
    @bookings_archived = @bookings_active_past + @bookings_event_cancelled + @bookings_cancelled
    raise
  end

  private
  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

end
