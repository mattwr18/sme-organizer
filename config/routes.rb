# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'homepage#index'

  resources :purchases
  resources :clients
  resources :vendors
  resources :ingredients
  resources :products_sales, only: %i[index show]
  resources :sales do
    post 'products_search'
  end

  resources :products do
    get 'ingredients_search'
    get 'search'
    resources :products_ingredients do
    end
  end
end
