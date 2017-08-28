Rails.application.routes.draw do

  get 'static_pages/home'

  get 'static_pages/about'

  root 'users#index'
  get 'users' => 'users#index'

  post 'users' => 'users#create'
  get 'users/new' => 'users#new'

  get 'users/:id' =>'user#show'


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
