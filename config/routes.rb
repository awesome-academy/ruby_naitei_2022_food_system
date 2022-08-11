Rails.application.routes.draw do
  root to: "home#home"
  namespace :admin do
    root to: "dashboard#index"
  end
end
