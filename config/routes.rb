Rails.application.routes.draw do

  #顧客用
  devise_for :admin, skip: [:registrations, :passwords], controller: {
    sessions: "admin/sessions"
  }

  #管理者用
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  namespace :admin do
    resources :users, only:[:index, :show, :update]
    resources :posts, only:[:index, :show, :destroy]
    get '/search' => 'searches#search'
  end

  scope module: :public do
    resource :users, only:[:show] do
      collection do
        patch "information/update" => "customers#update", as:"update"
        get "information/edit" => "customers#edit", as:"edit"
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
    resources :posts, only:[:index, :show, :new, :create, :destroy]
    get '/search' => 'searches#search'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
