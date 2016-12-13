class BookingMailer < ApplicationMailer

  def user_subscription(user, event)
    @greeting = "Hi"
    @event = event
    @user = user
    mail(to: event.user.email, subject: t('booking_mailer.user_subscription.subject', participant_name: user.first_name.capitalize, event_name: event.name))
  end

  def user_unsubscription(user, booking)
    @greeting = "Hi"
    @booking = booking
    @event = booking.event
    @user = user
    mail(to: event.user.email, subject: t('booking_mailer.user_unsubscription.subject',unsubscribe_participant_name: user.first_name.capitalize, event_name: event.name))
  end

  # def reimbursement_status(user,booking)
  #   @greeting = "Hi"
  #   @booking = booking
  #   mail(to: @user.email, subject: t('user_mailer.user_subscription.subject'))
  # end

  # def user_comment(user, booking)
  #   @greeting = "Hi"
  #   @user = user
  #   @event = booking.event
  #   mail(to: @user.email, subject: 'Quelqu\'un a ajouté un commentaire à votre événement')
  # end
end
