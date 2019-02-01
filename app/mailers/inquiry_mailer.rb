# frozen_string_literal: true

# Send mail about inquiries to users
class InquiryMailer < ApplicationMailer
  def realtor_response(hunter)
    mail to: hunter.email, subject: 'Thank you for you inquiry!'
  end
end
