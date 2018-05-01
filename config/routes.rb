Rails.application.routes.draw do
  root :to => 'homepage#index'

  resources :sales
  resources :purchases
  get '/profit' => 'profit#index'
end
