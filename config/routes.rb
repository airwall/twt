Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "users#index", as: "users"
  end

  unauthenticated :user do
    root "static_pages#index"
  end


  get '/users', to: redirect { |params, request|
    home = request.env["warden"].user(:user)
    home ? ('/users/' + home.id) : '/users'
  }

  resources :users do
    member do
      get :following, :followers
      patch :follow, :unfollow
    end
  end

  resources :tweets, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
