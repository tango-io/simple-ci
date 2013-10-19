R13Team186::Application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :pages
  root to: 'pages#index'
end
