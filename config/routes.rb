Rails.application.routes.draw do

  root 'shows#index'
  resources :venues
  resources :shows

  resources :bands
end
