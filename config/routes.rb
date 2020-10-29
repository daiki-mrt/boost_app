Rails.application.routes.draw do
  root to: "rooms#index"
  devise_for :users
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#new_guest"
  end
  resources :users, only: :show do
    resources :relationships, only: [:create, :destroy]
    member do
      get :follows
      get :followers
    end
  end

  resources :rooms do
    resources :comments, only: :create
    member do
      get :confirm
      get :join
    end
  end

  resources :spaces, only: :show do
    resources :messages, only: :create
  end


end
