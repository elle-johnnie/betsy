Rails.application.routes.draw do
  root 'products#home'

  get "/auth/:provider/callback", to: "sessions#create", as: "login"

  resources :products do
    resources :reviews, only: [:new, :create]
  end

  get "/auth/:provider/callback", to: "sessions#create", as: "auth_callback"
  delete "/logout", to: "sessions#destroy", as: "logout"

  resources :reviews

  resources :carts, only: [:show, :new]

  patch 'order_items/:id/ship', to: "order_items#ship", as: "ship_item"
  post "order_items/cart_direct/:id", to: "order_items#cart_direct", as: "quick_shop"
  resources :order_items, only: [:create, :update, :destroy]

  resources :orders
  patch 'order/confirm_order/:id', to: "order#confirm_order", as: "confirm_order"
  patch 'order/:id/cancel', to: "order#cancle_order", as:"cancel_order"
  get 'products/category/:id', to: "products#category", as: "category"
  patch 'products/:id/retire', to: "products#status", as: "product_status"
  get 'products/merchant/:id', to: "products#merchant", as: "merchant"
  resources :products

  resources :users

  resources :users do
    resources :products, only: [:index, :show, :new]
      # resources :orders, only: [:index, :show]
  end



  resources :categories

end
