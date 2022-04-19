Rails.application.routes.draw do
  # get 'events/create'
  # get 'events/update'

  resources :events
  
  resources :tickets do
    post 'reserve',             on: :collection
    post 'purchase',            on: :collection
    post 'cancel_reservation',  on: :collection
    post 'block_ticket',        on: :collection
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
