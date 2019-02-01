# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#index'

  as :administrators do
    get 'administrators', to: 'administrators#show', as: :administrator_root
  end
  devise_for :administrators, path: 'administrators',
                              controllers: {
                                sessions: 'administrators/sessions',
                                registrations: 'administrators/registrations'
                              }
  resources :administrators, only: [:index]

  as :realtor do
    get 'realtors', to: 'realtors#show', as: :realtor_root
  end
  devise_for :realtors, path: 'realtors',
                        controllers: {
                          registrations: 'realtors/registrations',
                          sessions: 'realtors/sessions'
                        }
  resources :realtors, only: [:index]
  resources :realtors, path: 'administrators/manage/realtors',
                       controller: 'administrators/manage_realtors',
                       as: :realtor
  devise_scope :realtor do
    get '/auth/google_oauth2/callback' => 'omniauth/omniauth_callbacks#google_oauth2'
  end

  as :hunter do
    get 'hunters', to: 'hunters#show', as: :hunter_root
  end
  devise_for :hunters, path: 'hunters',
                       controllers: {
                         registrations: 'hunters/registrations',
                         sessions: 'hunters/sessions'
                       }
  resources :hunters, only: [:index]
  resources :hunters, path: 'administrators/manage/hunters',
                      controller: 'administrators/manage_hunters',
                      as: :hunter
  get 'hunters/wishlist', 'hunters#wishlist'
  devise_scope :hunter do
    get '/auth/google_oauth2/callback' => 'omniauth/omniauth_callbacks#google_oauth2'
  end

  resources :real_estate_companies

  resources :houses do
    member do
      post 'add_to_wl'
      delete 'remove_from_wl'
    end
  end
  get 'search', action: 'search', controller: 'houses'
  post 'search', action: 'search', controller: 'houses'

  resources :inquiries

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
