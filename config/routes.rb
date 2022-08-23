Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    resources :products, only: :show
    get "/menu", to: "home#menu"
    namespace :admin do
      root to: "dashboard#index"
      resources :categories, except: :show
      resources :products
      resources :users, only: %i(index show destroy)
      resources :orders
    end
  end
end
