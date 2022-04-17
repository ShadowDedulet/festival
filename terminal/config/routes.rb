Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/journal', to: 'actions#index'
  get '/enter', to: 'actions#enter'
  get '/exit', to: 'actions#exit'
  # post '/enter', to: 'actions#entry'
  # post '/exit', to: 'actions#exit'
end
