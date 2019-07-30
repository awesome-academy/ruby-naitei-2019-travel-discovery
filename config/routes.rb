Rails.application.routes.draw do
  root "static_pages#home"
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: %i(create destroy)
  resources :reactions, only: %i(show create destroy)
  resources :comments, only: %i(show create destroy)

  namespace :admin do
    root "/admin#index"
    resources :cities
  end
end
