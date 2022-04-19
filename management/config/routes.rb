Rails.application.routes.draw do
  root 'users#get_cancel_reservation'

  resources :users do
    get :get_purchase
    get :get_reserve
    get :get_cancel_reservation
  end

  resources :sessions, only: [:new, :create, :destroy]
end
