Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions' }

  resources :posts, except: %i[edit update destroy] do
    resources :comments, only: :show
  end
end
