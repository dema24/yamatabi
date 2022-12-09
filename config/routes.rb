Rails.application.routes.draw do

  #顧客用
  devise_for :admin, skip: [:registrations, :passwords], controller: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    resources :users, only:[:index, :show, :update]
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
    end
    resources :posts, only:[:index, :show, :new, :create, :destroy]
    get '/search' => 'searches#search'
    root to: 'homes#top'
    get 'home/about' => 'homes#about', as: 'about'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
