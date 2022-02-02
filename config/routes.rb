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
    resources :documents, only: [:index, :destroy]
  end
  resources :document_groups, only: [:show, :update, :destroy] 

  namespace :api do
    namespace :v1 do
      resources :clients , only: [:index] do
        resources :vendors, only: [:index]    
      end
      resources :vendors, only: [:index,:create]    
      resources :vendors, only: [] do
        resources :documents, only: [:index]
      end
      resources :documents, only: [:index]
    end 
  end 
end
