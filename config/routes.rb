Zassman::Application.routes.draw do
  get "users/show"

  resources :assets

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  match 'users/:id' => 'users#show', as: :user

  root to: 'assets#index'
  get 'about' => 'pages#about'

end
