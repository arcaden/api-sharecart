Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :users, param: :_username
    namespace :api do
      namespace :v1 do
        resources :rooms
        resources :carts do 
          resources :items, only: [:index, :create]
        end
        resources :items, only: [:show, :update, :destroy]
      end
    end

    post '/auth/login', to: 'authentication#login'
    post '/auth/signup', to: 'users#create'
    get '*unmatched_route', to: 'application#not_found'
end
