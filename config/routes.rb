Rails.application.routes.draw do

  #顧客用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :users, only:[:index, :show, :edit, :update, :destroy]
    resources :posts, only:[:index, :show, :destroy]
    get '/search' => 'searches#search'
  end

  #管理者用
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    resources :users, only:[:index, :show, :edit, :update] do
      get 'unsubscribe'
      patch 'withdraw'
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :posts, only:[:index, :show, :new, :create] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    get '/search' => 'searches#search'
    root to: 'homes#top'
    get 'home/about' => 'homes#about', as: 'about'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
