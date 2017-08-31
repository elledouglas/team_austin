Rails.application.routes.draw do

  get 'sessions/new'

  root 'static_pages#home'
  get 'static_pages/home'
  get  '/about' => 'static_pages#about'

  root 'users#index'
  get 'users' => 'users#index'
  post 'users', to: 'users#create', as: 'create_user'
  get '/new', to: 'users#new', as: 'signup'
  get 'users/:id', to: 'users#show', as: 'user_profile'
  get 'users/:id/edit', to: 'users#edit', as: 'edit_user_profile'
  patch 'users/:id', to: 'users#update', as: 'update_user_profile'
  delete 'users/:id', to: 'users#destroy', as: 'delete_user_profile'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'



end
