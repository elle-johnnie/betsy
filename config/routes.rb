Rails.application.routes.draw do

  resources :carts, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]

  root 'products#home'

  resources :reviews
  resources :orders
  resources :products
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
