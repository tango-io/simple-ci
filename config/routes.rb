require 'sidekiq/web'

SimpleCI::Application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete "/signout" => "sessions#destroy", :as => :signout

  root to: 'pages#index'

  resources :jobs, only: [:create]

  resources :dashboard, only: [:index]

  resources :repositories, only: [:index, :create, :destroy]

  resources :pages, only: [:index] do
    collection do
      get :verify_gemfile
    end
  end

  resources :hooks, only: :index do
    collection do
      post :github
    end
  end

  namespace :api do
    resources :workers, only: [:index]
  end
end
