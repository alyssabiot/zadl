class PaymentsController < ApplicationController
  before_action :set_booking
  before_action :set_event

  def new
    authorize @booking
  end

  def create
    stripe_customer_id = current_user.stripe_customer_id

    unless stripe_customer_id
      customer = Stripe::Customer.create(
       source: params[:stripeToken],
       email:  params[:stripeEmail]
      )

      stripe_customer_id = customer.id
      current_user.update(stripe_customer_id: stripe_customer_id)
    end

    charge = Stripe::Charge.create(
     customer:     stripe_customer_id,
     amount:       @booking.amount_cents, # or amount_pennies
     description:  t('controllers.payments.payment', activity = @booking.event.name),
     currency:     @booking.amount.currency
    )
    authorize @booking

    @booking.update(payment: charge.to_json, state: 'paid')
    if @event.notif_subscription
      BookingMailer.user_subscription(current_user,@event).deliver_now
    end
    flash[:notice] = t('controllers.payments.confirmation')
    redirect_to event_path(@event)

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_event_booking_payment_path(@event, @booking)
  end

  private

  def set_booking
    @booking = Booking.where(state: "pending").find(params[:booking_id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end
