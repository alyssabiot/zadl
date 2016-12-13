class ApplicationMailer < ActionMailer::Base
  default from: 'hello@zadl.fr'
  layout 'mailer'
  add_template_helper(EmailHelper)
end
