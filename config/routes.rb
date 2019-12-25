require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root 'batches#new'

  resources :batches, only: [:new, :create, :show]
end
