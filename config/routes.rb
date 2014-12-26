Rails.application.routes.draw do

  devise_for :users
  root 'shows#index'
  resources :venues
  resources :shows do
  	resources :comments, only: [:new, :create, :destroy, :edit, :update]
  end
  resources :users, only: [:show]
  resources :bands
end
