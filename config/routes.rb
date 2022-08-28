Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users do
      resources :orders, except: %i(edit) do
        member do
          post :buy_again
        end
      end
    end
    get "/menu", to: "home#menu"
    resources :products, controller: :home, only: :show
    resource :carts, only: [:show, :create] do
      get "/clear", to: "carts#clear"
    end
    resources :carts, only: [:update, :destroy]
    resources :ratings, only: :create

    namespace :admin do
      root to: "dashboard#index"
      resources :categories, except: :show
      resources :products
      resources :users, only: %i(index show destroy)
      resources :orders do
        member do
          put :approve
          put :reject
          put :undo
        end
      end
    end
  end
end
