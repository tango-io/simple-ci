require 'sidekiq/web'

R13Team186::Application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :pages
  root to: 'pages#index'
end
