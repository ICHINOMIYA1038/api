Rails.application.routes.draw do
  resources :posts, param: :slug
  resources :users, only: [:index,:show,:new,:edit,:update, :create, :destroy]
  resources :tags, only:[:index]

  get '/users/:user_id/posts', to: 'posts#user_posts'

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end

  get 'favo', to:'users#favorites' 

  resources :users, only: [:show, :edit, :update] do
    get :favorites, on: :collection
  end
# 記事詳細表示のルーティングにネスト
  resources :posts do
    resource :favorites, only: [:create, :destroy]
  end

  get '/sample', to: 'posts#sample',param: :slug

  get '/post/:id/favo', to: 'posts#favo'

  get '/search', to: 'search#index'

  #人気順
  get '/tags/favorite', to: 'tags#favorite'
  #事前準備
  get '/tags/prepare', to: 'tags#prepare'

 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

end
