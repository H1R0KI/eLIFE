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

    #posts
    resources :posts,only: [:index,:show, :create, :update, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
