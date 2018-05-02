Rails.application.routes.draw do
  devise_for :users
  root :to => 'homepage#index'

  resources :sales
  resources :purchases
  get '/profit' => 'profit#index'
end
