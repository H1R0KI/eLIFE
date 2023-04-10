Rails.application.routes.draw do

  #管理者側
  devise_for :admin,  skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do

    #メンバー
    resources :members,only: [:index,:edit,:show,:update]
  end


  #会員側
  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do

    #ホーム
    root to: 'homes#top'
    get '/about' => 'homes#about'

    #メンバー
    resources :members,only: [:index, :edit, :show, :update] do
      resource :follows, only: [:create, :destroy]
      get 'followings' => 'follows#followings', as: 'followings'
      get 'followers' => 'follows#followers', as: 'followers'
    end

    devise_scope :member do
      post 'members/guest_sign_in', to: 'members/sessions#guest_sign_in'
    end

    #投稿
    resources :posts,only: [:new, :edit, :index, :show, :create, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end

    #タグ
    resources :tags do
      get 'posts', to: 'posts#search'
    end

    #検索
    get "search" => "searches#search"

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
