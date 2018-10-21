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
  resources :order_items, only: [:create, :update, :destroy]

  # post "/reviews/new/:id", to: "reviews#create", as: "create_review"
  # get "/reviews/new/:id", to: "reviews#new", as: "new_review"

  resources :orders

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
