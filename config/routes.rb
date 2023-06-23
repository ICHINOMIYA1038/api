Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :posts
  resources :users, only: [:index,:show,:new,:edit,:update, :create, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
