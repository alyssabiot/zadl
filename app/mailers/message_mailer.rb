class MessageMailer < ApplicationMailer
 def user_comment(user, message)
   @greeting = "Hi"
   @user = user
   @message = message
   @event = @message.event
   mail(to: @event.user.email, subject: t('message_mailer.user_comment.subject', comment_user: @user.first_name.capitalize, event_name: @event.name)
 end
end
