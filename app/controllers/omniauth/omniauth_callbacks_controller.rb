# frozen_string_literal: true

# Omniauth handling for multiple Models
class Omniauth::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    params = request.env['omniauth.params']
    if params['type'] == 'realtor'
      user = Realtor.from_omniauth(request.env['omniauth.auth'])
    elsif params['type'] == 'hunter'
      user = Hunter.from_omniauth(request.env['omniauth.auth'])
    end
    if is_navigational_format?
      flash[:notice] = 'Signed In successfully using Google+'
      flash[:class] = 'alert alert-success'
    end
    sign_in_and_redirect user
  end
end
