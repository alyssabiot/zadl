class EventMailer < ApplicationMailer

  def event_cancelled(participant, event)
    @greeting = "Hi"
    @participant = participant
    @event = event
    mail(to: @participant.email, subject: t('event_mailer.event_cancelled.subject', organizer: @event.user.first_name.capitalize, event_name: @event.name))
  end

  def event_created(user, event)
    @greeting = "Hi"
    @user = user
    @event = event
    mail(to: @user.email, subject: t('event_mailer.event_created.subject'))
  end

  def event_updated(participant, event)
    @greeting = "Hi"
    @participant = participant
    @event = event
    mail(to: @participant.email, subject: t('event_mailer.event_updated.subject', organizer: @event.user.first_name.capitalize, event_name: @event.name))
  end
end
