class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.dig(:mail, :user)
  layout 'mailer'
end
