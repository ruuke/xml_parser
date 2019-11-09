Rails.application.routes.draw do
  root 'batches#new'

  resources :batches
end
