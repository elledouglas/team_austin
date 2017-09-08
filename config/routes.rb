Rails.application.routes.draw do

  root 'static_pages#home'
  get 'static_pages/home'
  get  '/about' => 'static_pages#about'

  get 'users', to: 'users#index'


  post 'users/create', to: 'users#create', as: 'create_user'
  post 'users', to: 'users#index', as: 'search'
  get '/new', to: 'users#new', as: 'signup'

  get 'users/:id', to: 'users#show', as: 'user_profile'
  get 'users/:id/edit', to: 'users#edit', as: 'edit_user_profile'
  patch 'users/:id', to: 'users#update', as: 'update_user_profile'
  delete 'users/:id', to: 'users#destroy', as: 'delete_user_profile'

  get    '/login'   => 'sessions#new'
  post   '/login'   => 'sessions#create'
  delete '/logout'  => 'sessions#destroy'

  resources :password_resets,     only: [:new, :create, :edit, :update]

  resources :block_relationships,       only: [:create, :destroy]

  resources :winks,       only: [:create]


  resources :users do
    member do
      get :blocking
      get :wink_senders, :wink_recipients
    end
  end

  get 'users/instagram/add' => 'users#instagramadd'
  get '/users/oauth/callback' => 'users#instagram_callback'


  post '/users/sendmessage/:id' => 'users#send_email' ,as: 'sendemail'

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



end
