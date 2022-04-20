Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root 'users#show'

  resources :users do
    get :get_purchase
    get :purchase

    get :get_reserve
    get :reserve

    get :get_cancel_reservation
    get :cancel_reservation

    get :get_block_ticket
    get :block_ticket

    get :journal

    get 'tickets', on: :collection
  end
  
  # resources :tickets, only: :index
  resources :events, only: :index
  resources :sessions, only: %i[new create destroy]
end
