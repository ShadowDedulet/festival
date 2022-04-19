Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/journal', to: 'actions#index'
  
  post '/enter', to: 'actions#enter'
  post '/exit', to: 'actions#exit'
end
