R13Team186::Application.routes.draw do
  resources :pages
  root to: 'pages#index'
end
