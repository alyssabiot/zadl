class BookingsController < ApplicationController
  before_action :set_event, only: [ :create ]
  before_action :set_booking, only: [ :update, :destroy ]

  def create
    @booking = Booking.new(booking_params)
    @booking.event = @event
    @booking.user = current_user
    @booking.amount = @event.price
    @booking.state = "pending"
    authorize @booking
    if @booking.on_waiting_list
      if @booking.save
        if @event.notif_subscription
          BookingMailer.user_subscription(current_user, @event).deliver_now
        end
        flash[:notice] = t('controllers.bookings.subscription')
        redirect_to event_path(@event)
      else
        redirect_to event_path(@event)
      end
    elsif @booking.amount == 0
      @booking.state = 'paid'
      if @booking.save
        if @event.notif_subscription
          BookingMailer.user_subscription(current_user, @event).deliver_now
        end
        flash[:notice] = t('controllers.bookings.subscription')
        redirect_to event_path(@event)
      else
        redirect_to event_path(@event)
      end
    else
      if @booking.save
        redirect_to new_event_booking_payment_path(@event, @booking)
      else
        redirect_to event_path(@event)
      end
    end
  end

  def update
    @booking.on_waiting_list = booking_params[:on_waiting_list]
    status = booking_params[:reimbursed]
    if status == t('events.show.accept_reimbursement')
      @booking.reimbursed = "reimbursed"
    elsif status == t('events.show.refuse_reimbursement')
      @booking.reimbursed = "reimbursement refused"
    else
      @booking.reimbursed = "pending"
    end
    if booking_params[:state]
      @booking.state = booking_params[:state]
      @booking.cancellation_message = booking_params[:cancellation_message]
    end
    if current_user == @booking.user
      @booking.cancelled = false
      @booking.save
      authorize @booking
      if @booking.state == "paid"
        flash[:notice] = t('controllers.bookings.subscription_after_cancellation')
        redirect_to current_user
      else
        redirect_to new_event_booking_payment_path(@booking.event, @booking)
      end
    else
      @booking.save
      authorize @booking
      BookingMailer.reimbursement_status(@booking.user, @booking).deliver_now
      flash[:notice] = t('controllers.bookings.reimbursement', name: @booking.user.first_name)
      redirect_to event_path(@booking.event)
    end
  end

  def destroy
    @booking.cancelled = true
    @booking.cancellation_message = params[:booking][:cancellation_message]
    @booking.save
    BookingMailer.user_unsubscription(current_user, @booking).deliver_now
    flash[:notice] = t('controllers.bookings.unsubscription', name: @booking.event.user.first_name)
    redirect_to user_path(current_user)
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def booking_params
    params.require(:booking).permit(:on_waiting_list, :reimbursed, :state, :cancellation_message)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def has_a_booking_cancelled?(user, event)
    result = false
    user.bookings.each do |booking|
      if booking.event == event && booking.cancelled == true
        result = true
      end
    end
    return result
  end

  def booking_find_by_user_and_event(user,event)
    result = "No booking"
    user.bookings.each do |booking|
      if booking.event == event
        result = booking
      end
    end
    return result
  end
end
