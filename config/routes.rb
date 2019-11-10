Rails.application.routes.draw do
  root 'batches#new'

  resources :batches, only: [:new, :create, :show]
end
