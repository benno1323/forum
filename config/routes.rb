Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'

    resources :categories, :topics, :comments
  end

  resources :topics do
    resources :comments, only: :create
  end

  resources :categories do
    resources :topics
  end

  root 'categories#index'
end
