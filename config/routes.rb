Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1, path: '/' do
      resource :users
      resources :products, only: %i[index show]


      namespace :auth, path: "/" do
        post "/login", to: "sessions#create"
      end
    end
  end

end
