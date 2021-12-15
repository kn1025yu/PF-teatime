Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get   'inquiry'         => 'inquiry#index'     # 入力画面
  post  'inquiry/confirm' => 'inquiry#confirm'   # 確認画面
  post  'inquiry/thanks'  => 'inquiry#thanks'    # 送信完了画面
  
  
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :followings, :followers
      get :bookmarks
    end
  end

  resources :post_images, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
    resource :bookmarks, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  
  resources :tags do
    get 'post_images', to: 'post_images#search'
  end

  resources :relationships, only: [:create, :destroy]

  get '/search', to: 'searchs#search'

  post '/posts/new', to: 'posts#create', as: :create
end
