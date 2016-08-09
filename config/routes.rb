Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#index'
  get 'home' => 'home#index'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :tweets,  only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
