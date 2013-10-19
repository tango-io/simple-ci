require 'sidekiq/web'

R13Team186::Application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root to: 'pages#index'

  resources :pages do
    collection do
      get :verify_gemfile
    end
  end

  namespace :api do
    resources :workers, only: [:index]
  end
end
