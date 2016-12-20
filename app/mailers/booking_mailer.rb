class BookingMailer < ApplicationMailer

  def user_subscription(user, event)
    @greeting = "Hi"
    @event = event
    @user = user
    mail(to: @event.user.email, subject: t('booking_mailer.user_subscription.subject', participant_name: @user.first_name.capitalize, event_name: @event.name))
  end

  def user_unsubscription(user, booking)
    @greeting = "Hi"
    @booking = booking
    @event = booking.event
    @user = user
    mail(to: @event.user.email, subject: t('booking_mailer.user_unsubscription.subject',unsubscribe_participant_name: @user.first_name.capitalize, event_name: @event.name))
  end

  def reimbursement_status(user, booking)
    @greeting = "Hi"
    @booking = booking
    @event = booking.event
    mail(to: @booking.user.email, subject: t('booking_mailer.reimbursement_status.subject', organizer: @event.user.first_name.capitalize, event_name: @event.name))
  end

  def waiting_list(participant, event)
    @greeting = "Hi"
    @event = event
    @participant = participant
    mail(to: @participant.email, subject: t('booking_mailer.waiting_list.subject', event_name: @event.name))
  end
end
