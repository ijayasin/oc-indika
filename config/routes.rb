Rails.application.routes.draw do
  resources :maps
  namespace :admin do
    resources :users
    root to: "users#index"
  end
  root to: 'maps#index'
  devise_for :users
end
