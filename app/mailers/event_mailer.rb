class EventMailer < ApplicationMailer

  def event_edited_cancellation(participant, event)
    @greeting = "Hi"
    @participant = participant
    @event = event
    mail(to: @participant.email, subject: t('event_mailer.event_edited_cancellation.subject', organizer_name: @event.user.first_name.capitalize, event_name: @event.name))
  end

  # def event_created(user, event)
  #   @greeting = "Hi"
  #   @user = user
  #   @event =event
  #   mail(to: @user.email, subject: 'Votre événement a été créé ! Partagez-le !')
  # end

  # def event_edited_location(user, event)
  #   @greeting = "Hi"
  #   @user = user
  #   @participants = event.bookings.where(cancelled: false, on_waiting_list: false).map(&:user)
  #   mail(to: @user.email, subject: 'Attention, le lieu de votre activité à été modifiée')
  # end

  # def event_edited_date(user, event)
  #   @greeting = "Hi"
  #   @user = user
  #   @participants = event.bookings.where(cancelled: false, on_waiting_list: false).map(&:user)
  #   mail(to: @user.email, subject: 'Attention, la date de votre activité a été modifiée')
  # end
end
