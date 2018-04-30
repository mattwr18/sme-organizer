Rails.application.routes.draw do
  get 'profit/index'
  get 'purchases/index'
  get 'sales/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'homepage#index'

  get '/sales' => 'sales#index'
  get '/purchases' => 'purchases#index'
  get '/profit' => 'profit#index'
end
