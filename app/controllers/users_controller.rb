class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @booking = Booking.new
    @duplicated_event = Event.new
    # Tous les bookings en cours de l'user (yc. lorsqu'il organise ou lorsqu'il est en liste d'attente)
    @all_bookings_active = @user.bookings.joins(:event).where("events.active = ? AND bookings.cancelled = ? AND bookings.state = ?", true, false, 'paid') + @user.bookings.joins(:event).where("events.active = ? AND bookings.cancelled = ? AND bookings.on_waiting_list = ?", true, false, true)
    # Tous les bookings en cours de l'user à venir
    @bookings_active_to_come = @all_bookings_active.select do |booking|
      booking.event.starts_at >= DateTime.now()
    end
    # Tous les bookings en cours de l'user passés
    @bookings_active_past = @all_bookings_active.select do |booking|
      booking.event.starts_at < DateTime.now()
    end
    # Tous les bookings de l'user où l'event a été annulé
    @bookings_event_cancelled = @user.bookings.joins(:event).where("events.active = ?", false)
    # Tous les bookings de l'user où il a annulé sa participation
    @bookings_cancelled = @user.bookings.joins(:event).where("events.active = ? AND bookings.cancelled = ?", true, true)
    # Tous les bookings non archivés
    @bookings_not_archived = @bookings_active_to_come.sort_by { |booking| booking.event.starts_at }
    # Tous les bookings archivés non triés
    @bookings_archived_not_sorted = @bookings_active_past + @bookings_event_cancelled + @bookings_cancelled
    # Tous les bookings archivés triés
    @bookings_archived = @bookings_archived_not_sorted.sort_by { |booking| booking.event.starts_at }
    # Events non annulés organisés par @user triés par dte de création
    @events_organized = @user.events.where("events.active = ?", true).sort_by { |event| event.created_at }
    # Tous les bookings en cours de l'user (hors annulés et liste d'attente)
    @events_participated = @user.bookings.joins(:event).where("events.active = ? AND bookings.cancelled = ? AND bookings.state = ?", true, false, 'paid').sort_by { |event| event.created_at }
  end

  private
  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

end
