Rails.application.routes.draw do
  root 'products#home'

  resources :products do
    resources :reviews, only: [:new, :create]
  end


  get "/auth/:provider/callback", to: "sessions#create"

  get 'sessions/login', to: "sessions#new" #page for a new session
  delete "/logout", to: "sessions#destroy", as: "logout"

  # get 'sessions/new', to: "sessions#create" #create a new session login
  # get 'sessions/destroy', to: "sessions#destroy" #delete a session logout
  resources :reviews

  resources :carts, only: [:show]

  post "order_items/cart_direct/:id", to: "order_items#cart_direct", as: "quick_shop"
  resources :order_items, only: [:create, :update, :destroy]

  resources :reviews
  resources :orders

  get 'products/category/:id', to: "products#category", as: "category"
  get 'products/merchant/:id', to: "products#merchant", as: "merchant"
  resources :products
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
