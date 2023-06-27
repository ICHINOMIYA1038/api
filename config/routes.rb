Rails.application.routes.draw do
  resources :posts
  resources :users, only: [:index,:show,:new,:edit,:update, :create, :destroy]

  get '/users/:user_id/posts', to: 'posts#user_posts'
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
