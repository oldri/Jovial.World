# app/mailers/application_mailer.rb
class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@jovialworld.com'
  layout 'mailer'
end
