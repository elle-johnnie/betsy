Rails.application.routes.draw do
  root 'products#home'

  get "/auth/:provider/callback", to: "sessions#create", as: "login"

  resources :products do
    resources :reviews, only: [:new, :create]
  end

  get "/auth/:provider/callback", to: "sessions#create"

  # get 'sessions/login', to: "sessions#new" #page for a new session
  delete "/logout", to: "sessions#destroy", as: "logout"

  # get 'sessions/new', to: "sessions#create" #create a new session login
  # get 'sessions/destroy', to: "sessions#destroy" #delete a session logout
  resources :reviews

  resources :carts, only: [:show]

  patch 'order_items/:id/ship', to: "order_items#ship", as: "ship_item"
  post "order_items/cart_direct/:id", to: "order_items#cart_direct", as: "quick_shop"
  resources :order_items, only: [:create, :update, :destroy]

  resources :reviews
  resources :orders

  get 'products/category/:id', to: "products#category", as: "category"
  patch 'products/:id/retire', to: "products#status", as: "product_status"
  get 'products/merchant/:id', to: "products#merchant", as: "merchant"
  resources :products
  resources :users
  resources :categories

end
