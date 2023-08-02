Rails.application.routes.draw do
  resources :posts, param:  :id
  resources :users, only: [:index,:show,:new,:edit,:update, :create, :destroy]
  resources :tags, only:[:index]

  # ユーザーごとの投稿の取得
  get '/users/:user_id/posts', to: 'posts#user_posts'
  # ユーザーの編集
  post '/setting' ,to: 'users#setting'

  #ユーザー認証のためのルーティング
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: "api/v1/auth/registrations"
      }
    end
  end

  #お気に入りに登録した投稿の取得
  get 'favo', to:'users#favorites' 

  #それぞれのユーザーに対してのお気に入りの記事の取得
  resources :users, only: [:show] do
    get :favorites, on: :collection
  end
  
# 記事詳細表示のルーティングにネスト
  resources :posts do
    resource  :favorites, only: [:create, :destroy]
    resources :comments, only: [:index] do
      collection do
        get :parent
        get 'parent/:comment_id', action: :show_child, as: :show_child
      end
    end
  end

  get '/post/:id/favo', to: 'posts#favo'
  get '/posts/:id/favo_num', to: 'posts#favo_num'

  get '/search', to: 'search#index',param: :slug

  #人気順
  get '/tags/favorite', to: 'tags#favorite'
  #事前準備
  get '/tags/prepare', to: 'tags#prepare'

  resources :comments, only: [:create, :destroy] 
  resources :contacts, only: [:create]

  get '/current_user', to: 'users#current_user'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/redirect/confirm', to: 'redirects#redirect_to_confirm'
  get '/redirect/reset', to: 'redirects#redirect_to_reset'
end
