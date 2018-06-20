# frozen_string_literal: true

Rails.application.routes.draw do
  scope '/:locale', locale: /en|pt-BR/ do
    devise_for :users
    root to: 'homepage#index'

    resources :purchases
    resources :clients
    resources :vendors
    resources :ingredients
    resources :products do
      post 'search'
    end
    resources :sales
    resources :products_sales, only: %i[index show]
  end
end
