class MessageMailer < ApplicationMailer
 def user_comment(user, booking)
   @greeting = "Hi"
   @user = user
   @event = booking.event
   mail(to: event.user.email, subject: 'Quelqu\'un a ajouté un commentaire à votre événement', comment_user: user.first_name.capitalize, event_name: event.name)
 end
end
