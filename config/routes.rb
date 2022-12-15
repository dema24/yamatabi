Rails.application.routes.draw do

  #管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :users, only:[:index, :show, :edit, :update, :destroy]
    resources :posts, only:[:index, :show, :destroy]
    get '/search' => 'searches#search'
  end

  #会員用
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :user do
    post 'users/guest_sign_in' => 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    resources :users, only:[:index, :show, :edit, :update] do
      member do
        get 'unsubscribe'
        patch 'withdraw'
        get 'favorite'
        resource :relationships, only: [:create, :destroy]
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
     end
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
