class MessageMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.user_comment.subject
  #
  def user_comment
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
