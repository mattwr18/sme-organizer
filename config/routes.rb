# frozen_string_literal: true

Rails.application.routes.draw do
  get 'products_sales/index'
  get 'products_sales/show'
  devise_for :users
  root to: 'homepage#index'

  resources :sales
  resources :purchases
  resources :clients
  resources :products
  resources :vendors
  resources :ingredients
  resources :products_sales, only: [:index, :show]
  get '/profit' => 'profit#index'
end
