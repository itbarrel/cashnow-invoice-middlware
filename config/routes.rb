# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'home#index'
  devise_for :users
  resources :clients do
    member do
      post :fetch_token
      get :fetch_ftp
    end
    resources :apis
    resources :vendors do
      member do
        post :fetch_data
      end
    end
  end
  resources :vendors, only: [] do
    resources :documents, only: %i[index destroy]
  end
  resources :document_groups, only: %i[show update destroy]

  namespace :api do
    namespace :v1 do
      resources :clients, only: [:index] do
        resources :vendors, only: [:index]
      end
      resources :vendors, only: %i[index create update destroy]
      resources :vendors, only: [] do
        resources :documents, only: [:index]
      end
      resources :documents, only: %i[index create update destroy]
    end
  end
end
