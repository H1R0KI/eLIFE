Rails.application.routes.draw do

  #管理者側
  devise_for :admin,  skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  #会員側
  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do

    #homes
    root to: 'homes#top'
    get '/about' => 'homes#about'

    #members
    resources :members,only: [:index, :edit, :show, :update]

    devise_scope :member do
      post 'members/guest_sign_in', to: 'members/sessions#guest_sign_in'
    end

    #posts
    resources :posts,only: [:new, :edit, :index, :show, :create, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
