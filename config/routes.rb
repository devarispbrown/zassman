Zassman::Application.routes.draw do
  resources :activities

  get "users/show"
  get 'tags/:tag', to: 'assets#index', as: :tag

  resources :assets do
    resources :comments, only: :create
    collection do
      get :search
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  match 'users/:id' => 'users#show', as: :user

  root to: 'assets#index'
  get 'about' => 'pages#about'

end
