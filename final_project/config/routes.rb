Rails.application.routes.draw do

  root 'static_pages#home'

  get 'static_pages/home'

  get  '/about' => 'static_pages#about'

  root 'users#index'
  get 'users' => 'users#index'

  post 'users', to: 'users#create', as: 'create_user'
  get '/new', to: 'users#new', as: 'signup'




  get 'users/:id', to: 'users#show', as: 'user_profile'

  # resources :users




  # get 'users/index'
  #
  # get 'users/new'
  #
  # get 'users/create'
  #
  # get 'users/edit'
  #
  # get 'users/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# resources :users
end
