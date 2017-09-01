Rails.application.routes.draw do

  get 'password_resets/new'
  get 'password_resets/edit'

  get 'sessions/new'
 get 'users/edit'

get 'users/instagram/add' => 'users#instagramadd'
  root 'static_pages#home'
  get 'static_pages/home'
  get  '/about' => 'static_pages#about'

  root 'users#index'

  get 'users', to: 'users#index'
  post 'users', to: 'users#create', as: 'create_user'
  get '/new', to: 'users#new', as: 'signup'
  get 'users/:id', to: 'users#show', as: 'user_profile'
  get 'users/:id/edit', to: 'users#edit', as: 'edit_user_profile'
  patch 'users/:id', to: 'users#update', as: 'update_user_profile'
  delete 'users/:id', to: 'users#destroy', as: 'delete_user_profile'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  post '/users/sendmessage/:id' => 'users#send_email' ,as: 'sendemail'

#
#   get "/users/instagram" do
#     redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL, :scope => 'comments relationships likes')
#   end
#
#   get "/users/instagram" do
#     response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
#     session[:access_token] = response.access_token
#     redirect "/feed"
#   end
# #
#   get "/feed" do
#     client = Instagram.client(:access_token => session[:access_token])
#     user = client.user
# end
#
# get "/" do
#   '/users/instagram/add'
# end
#
# get "/access_token" do
#   'access_token: ' + session[:access_token]
# end



  resources :password_resets,     only: [:new, :create, :edit, :update]


end
