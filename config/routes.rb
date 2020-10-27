Rails.application.routes.draw do
  root to: "rooms#index"
  devise_for :users
  resources :rooms do
    resources :comments, only: :create
    member do
      get :join
    end
  end

end
