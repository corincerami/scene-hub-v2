Rails.application.routes.draw do

  devise_for :users
  root 'shows#index'
  resources :venues

  resources :shows do
  	resources :comments, only: [:new, :create, :destroy, :edit, :update]
    resources :rsvps, only: [:new, :create]
  end
  resources :rsvps, only: :destroy
  resources :users, only: [:show]

  resources :bands do
  	resources :band_posts, only: [:new, :create, :destroy, :edit, :update]
    resources :photos, only: [:new, :create]
    resources :follows, only: [:create]
  end
  resources :follows, only: [:destroy]
  resources :photos, only: [:destroy]

end
