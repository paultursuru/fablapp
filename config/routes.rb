Rails.application.routes.draw do
  get 'pages/dashboard'
  root 'machines#index'
  devise_for :users
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
