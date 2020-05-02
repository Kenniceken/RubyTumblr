Rails.application.routes.draw do
  root to: 'posts#index'
  resources :posts do
    resources :comments
  end
  resources :tags, only: [:index, :show]
  resources :comments
  resources :authors

  resources :author_sessions, only: [ :new, :create, :destroy ]

  get 'login'  => 'author_sessions#new'
  get 'logout' => 'author_sessions#destroy'
end
