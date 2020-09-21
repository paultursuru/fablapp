Rails.application.routes.draw do
  root 'machines#index'
  devise_for :users
  resources :machines, only: [:index, :show] do
    resources :bookings, only: [:create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
