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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
