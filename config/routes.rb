Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions' }

  resources :posts, except: %i[edit update destroy] do
    scope module: :posts do
      resources :comments, only: :create
    end
  end
end
