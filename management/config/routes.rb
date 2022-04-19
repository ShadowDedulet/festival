Rails.application.routes.draw do
  root 'users#get_cancel_reservation'

  resources :users do
    get :get_purchase
    get :purchase

    get :get_reserve
    get :reserve

    get :get_cancel_reservation
    get :cancel_reservation

    get :get_block_ticket
    get :block_ticket
  end

  resources :sessions, only: %i[new create destroy]
end
