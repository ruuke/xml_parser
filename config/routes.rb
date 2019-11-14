Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'batches#new'

  resources :batches, only: [:new, :create, :show]
end
