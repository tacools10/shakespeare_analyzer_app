Rails.application.routes.draw do

  root to: 'pages#home'


  resources :pages, only: [:create, :new]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
