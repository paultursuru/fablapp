Rails.application.routes.draw do
  root 'bookings#index'
  devise_for :users, controllers: { registrations: 'users/registrations' , invitations: 'users/invitations'}
  get 'users/sign_up', to: redirect('/users/sign_in', status: 302)
  resources :machines, only: [:index, :show] do
    resources :bookings, only: [:create]
  end
  resources :bookings, only: [:index, :destroy]

  namespace :admin do
    delete "users/:id", to: "pages#destroy", as: 'destroy_user'
    get 'new_user', to: 'pages#new_user', as: 'new_user'
    post 'add_user', to: 'pages#add_user', as: 'add_user'
    post 'reboot_password', to: 'pages#reboot_password', as: 'reboot_password'
    get 'users', to: 'pages#index', as: 'users'
    get 'users/:id/formations', to: 'users#formations', as: 'user_formations'
    post 'formation_toggle', to: 'formations#formation_toggle', as: 'formation_toggle'
    resources :machines do
      resources :bookings, only: [:create]
    end
    resources :bookings, only: [:index, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
