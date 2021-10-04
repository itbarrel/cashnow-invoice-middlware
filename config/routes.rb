Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :clients do
    resources :vendors
  end
  # devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout"}
end
