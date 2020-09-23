Rails.application.routes.draw do
  root 'bookings#index'
  devise_for :users, controllers: { registrations: 'users/registrations' , invitations: 'users/invitations'}
  get 'users/sign_up', to: redirect('/users/sign_in', status: 302)
  resources :machines, only: [:index, :show] do
    resources :bookings, only: [:create]
  end
  resources :bookings, only: [:index, :destroy]

  namespace :admin do
    delete "users/:id", to: "users#destroy", as: 'destroy_user'
    resources :machines do
      resources :bookings, only: [:create]
    end
    resources :bookings, only: [:index, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
