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
  resources :invoice_groups, only: [:show, :destroy] 
  # devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout"}
end
