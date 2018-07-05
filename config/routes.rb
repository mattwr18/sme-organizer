# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'homepage#index'

  resources :purchases
  resources :clients
  resources :vendors
  resources :ingredients
  resources :products 
  resources :sales
  resources :products_sales, only: %i[index show]
end
