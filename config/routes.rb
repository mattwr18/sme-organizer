Rails.application.routes.draw do
  devise_for :users
  root :to => 'homepage#index'

  resources :sales
  resources :purchases
  resources :clients
  get '/profit' => 'profit#index'
end
