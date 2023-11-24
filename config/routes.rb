Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1, path: '/' do
      resources :users do
        resources :orders
      end
      resources :products, only: %i[index show]
      resources :comments, only: %i[create]
      resources :wish_lists, only: %i[index create destroy]
      resources :order_items, only: %i[index create update destroy]


      namespace :auth, path: "/" do
        post "/login", to: "sessions#create"
      end
    end
  end

end
