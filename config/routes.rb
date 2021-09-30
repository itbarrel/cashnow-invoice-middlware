Rails.application.routes.draw do
  root 'home#index'
  # devise_for :users
  # root to "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout"}
end
