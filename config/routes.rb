Rails.application.routes.draw do
  root 'website#home'

  resources :user_registrations, only: [:new, :create]
end
