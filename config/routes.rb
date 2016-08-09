Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
     root to: "home#index", as: "home"
   end

   unauthenticated :user do
     root 'static_pages#index'
   end

  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :tweets,  only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
