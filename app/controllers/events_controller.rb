class EventsController < ApplicationController
  before_action :set_user, only: [:new, :create]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :ics_export, :withdraw]
  skip_before_action :authenticate_user!, only: [ :show ]

  def new
    @event = current_user.events.new(name: params[:event_name])
    authorize @event
  end

  def create
    @event = current_user.events.new(event_params)

    if !@event.photo.present? && event_params[:photo].present?
      cloudinary_url = URI.parse(event_params[:photo])
      file = cloudinary_url.open
      @event.photo = file
    end

    authorize @event
    if @event.save
      EventMailer.event_created(current_user, @event).deliver_now
      @booking = Booking.new
      @booking.event = @event
      @booking.user = current_user
      @booking.state = 'paid'
      @booking.save
      authorize @booking
      flash[:notice] = t('controllers.events.creation')
      redirect_to event_path(@event)
    else
      flash[:alert] = t('controllers.events.creation-error')
      render :new
    end
  end

  def edit
  end

  def update
    @event.update(event_params)
    if @event.save
      @participants = @event.bookings.where(cancelled: false, on_waiting_list: false, state: 'paid').map(&:user)
      @participants.each do |participant|
        if !participant.nil?
          EventMailer.event_updated(participant, @event).deliver_now
        end
      end
      flash[:notice] = t('controllers.events.update')
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def show
    @booking = Booking.new
    @duplicated_event = Event.new
    @participants = @event.bookings.where(cancelled: false, on_waiting_list: false, state: 'paid').map(&:user)
    @participants_number = @participants.count
    @message = Message.new
    if @event.max_participants
      (@event.max_participants - @participants_number).times do
      @participants << nil
      end
    end
    @bookings_cancelled = @event.bookings.where(cancelled: true)
    @bookings_cancelled_number = @bookings_cancelled.count

    if current_user
      @existing_booking = current_user.bookings.where(event: @event, cancelled: false).first
    end

    if current_user
      @cancelled_booking = current_user.bookings.where(event: @event, cancelled: true).first
    end

    if @event.latitude
      @hash_event = Gmaps4rails.build_markers(@event) do |event, marker|
        marker.lat event.latitude
        marker.lng event.longitude
        marker.picture({
          url: ActionController::Base.helpers.asset_path("custom_marker.png"),
          width:  32,
          height: 32
        })
      end
    end
  end

  def destroy
    @event.active = false
    @participants = @event.bookings.where(cancelled: false, on_waiting_list: false, state: 'paid').map(&:user)
    @event.save
    @participants.each do |participant|
      if !participant.nil?
        EventMailer.event_cancelled(participant, @event).deliver_now
      end
    end
    flash[:notice] = t('controllers.events.cancellation')
    redirect_to user_path(current_user)
  end

  def ics_export
    respond_to do |format|
      format.html
      format.ics do
        cal = Icalendar::Calendar.new
        event = Icalendar::Event.new
        event.dtstart = @event.starts_at
        event.dtend = @event.ends_at
        event.summary = @event.name
        event.description = @event.description
        cal.add_event(event)
        cal.publish
        render :text => cal.to_ical
      end
    end
  end

  def withdraw
    @event.withdrawed = true
    @event.save
    redirect_to event_path(@event)
    flash[:notice] = t('events.show.withdraw_notification', event: @event.name)
  end

  private



  def set_user
    @user = User.find(params[:user_id])
  end

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end

  def event_params
    params.require(:event).permit(:active, :name, :description, :starts_at, :ends_at, :max_participants, :price, :photo, :photo_cache, :location, :notif_subscription, :notif_cancellation, :notif_message, :withdrawed)
  end

end
