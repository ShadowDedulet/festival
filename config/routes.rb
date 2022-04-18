Rails.application.routes.draw do
  resource :login, only: %i[show create destroy]
end
