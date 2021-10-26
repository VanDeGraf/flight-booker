Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :flights, only: [:index]
  resources :bookings, only: [:new, :create, :show, :index]
  resources :passengers, only: [:index]
  root 'flights#index'
end
