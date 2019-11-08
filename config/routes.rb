Rails.application.routes.draw do
  root 'batches#new'

  resources :batches, only: %i[new create]
end
