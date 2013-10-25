require 'sidekiq/web'

SimpleCI::Application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete "/signout" => "sessions#destroy", :as => :signout

  root to: 'pages#index'

  resources :jobs, only: [:create]

  resources :dashboard, only: [:index]

  resources :pages, only: [:index] do
    collection do
      get :verify_gemfile
    end
  end

  namespace :api do
    resources :workers, only: [:index]
  end
end
