# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'homepage#index'

  resources :sales
  resources :purchases
  resources :clients
  resources :products
  resources :vendors
  get '/profit' => 'profit#index'
end
