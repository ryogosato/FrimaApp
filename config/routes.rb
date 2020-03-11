Rails.application.routes.draw do

  devise_for :users
  root 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end

  resources :items, only:[:show, :new, :create, :edit, :destroy] do
    member do
      get 'confirm', to: 'items#confirm'
      post 'pay', to: 'items#pay'
      get 'done', to: 'items#done'
    end
  end

  resources :users, only: [:index, :show]


end
