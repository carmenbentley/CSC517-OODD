# frozen_string_literal: true

# Send emails when new accounts are created
class AccountMailer < ApplicationMailer
  def new_account(email, password, type)
    @email = email
    @type = type == :realtor ? 'Realtor' : 'House Hunter'
    @password = password
    mail to: email, subject: 'Welcome to FullHouse!'
  end
end
