Rails.application.routes.draw do
  devise_for :users
  authenticated :user do
    root to: "users#index", as: "users"
  end

  unauthenticated :user do
    root "static_pages#index"
  end

  resources :users do
    resources :tweets, only: :create
    member do
      get  :following, :followers
      post :follow, :unfollow
      get  :timeline
    end
  end

  resources :relationships, only: [:create, :destroy]
end
