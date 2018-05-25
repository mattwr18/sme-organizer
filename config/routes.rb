# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'homepage#index'

  resources :purchases
  resources :clients
  resources :vendors
  resources :ingredients
  resources :products_sales, only: [:index, :show]
  resources :sales do
    get 'products_search', on: :collection
  end
  resources :products do
    get 'ingredients_search', on: :collection
  end
end
