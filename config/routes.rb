Rails.application.routes.draw do
  root to: "users#new"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get "signup", to: "users#new"
  resources :users, only:[:index, :show, :new, :create, :edit, :update] do
    member do
      get :followings
      get :followers
      get :favorite_works
      get :comment_works
    end
  end
  
  resources :works, only:[:create, :show, :destroy]
  resources :relationships, only:[:create, :destroy]
  resources :favorites, only:[:create, :destroy]
  resources :comments, only:[:create]
  
end
