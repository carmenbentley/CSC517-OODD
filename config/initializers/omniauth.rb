# frozen_string_literal: true

# Configure Omniauth providers
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           Rails.application.credentials.dig(:google_plus, :app_id),
           Rails.application.credentials.dig(:google_plus, :client_secret)

  on_failure do |env|
    # we need to setup env
    env['devise.mapping'] = Devise.mappings[:user] if env['omniauth.params'].present?
    Devise::OmniauthCallbacksController.action(:failure).call(env)
  end
end
