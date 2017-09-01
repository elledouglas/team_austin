Rails.application.routes.draw do

root 'static_pages#home'
get 'static_pages/home'
get  '/about' => 'static_pages#about'
root 'users#index'

get '/users/oauth/callback' => 'users#instagram_callback'
get 'users' => 'users#index'
post 'users' => 'users#create', as: 'create_user'
get '/new' => 'users#new', as: 'signup'
get 'users/:id' => 'users#show', as: 'user_profile'

get 'users/:id/edit' =>'users#edit' , as: 'edit_user_profile'
patch 'users/:id' =>'users#update' , as: 'update_user_profile'
delete 'users/:id/' =>'users#destroy' , as: 'delete_user_profile'

  get 'sessions/new'


  get 'users/instagram/add' => 'users#instagramadd'










  post '/users/sendmessage/:id' => 'users#send_email' ,as: 'sendemail'


  get    '/login'   => 'sessions#new'
  post   '/login'   => 'sessions#create'
  delete '/logout'  => 'sessions#destroy'

resources :password_resets,  only: [:new, :create, :edit, :update]

end
