Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"

  root 'home#index'
  devise_for :users
  resources :clients do
    member do
      post :fetch_token
    end
    resources :apis
    resources :vendors do
      member do
        post :fetch_data
      end
    end
  end
  resources :vendors, only: [] do
    resources :invoices, only: [:index, :destroy]
  end
  resources :invoice_groups, only: [:show, :update, :destroy] 
end
