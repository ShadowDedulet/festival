Rails.application.routes.draw do
  root 'sessions#home'

  resources :users, only: :show do
    get :get_purchase
    get :get_reserve
    get :get_cancel_reservation
  end

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
end
