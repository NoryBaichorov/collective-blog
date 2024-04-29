# frozen_string_literal: true

Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  root 'posts#index'

  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions' }

  resources :posts, except: %i[edit update destroy] do
    scope module: :posts do
      resources :comments, only: :create
      resources :likes, only: %i[create destroy]
    end
  end
end
