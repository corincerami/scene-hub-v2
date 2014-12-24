Rails.application.routes.draw do

  devise_for :users
  root 'shows#index'
  resources :venues
  resources :shows
  resources :users, only: [:show]
  resources :bands
end
