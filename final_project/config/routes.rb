Rails.application.routes.draw do

  get 'sessions/new'
 get 'users/edit'
get 'users/instagram/add' , to: 'users#instagramadd'
  root 'static_pages#home'

  get 'static_pages/home'
  get  '/about' => 'static_pages#about'

  root 'users#index'
  get 'users' => 'users#index'
  post 'users', to: 'users#create', as: 'create_user'
  get '/new', to: 'users#new', as: 'signup'

  get 'users/:id', to: 'users#show', as: 'user_profile'
  post '/users/sendmessage/:id', to: 'users#send_email' ,as: 'sendemail'


  get "/users/instagram" do
    redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL, :scope => 'comments relationships likes')
  end

  get "/users/instagram" do
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
    session[:access_token] = response.access_token
    redirect "/feed"
  end

  get "/feed" do
    client = Instagram.client(:access_token => session[:access_token])
    user = client.user
end

get "/" do
  '<a href="/users/instagram/add">Connect with Instagram</a>'
end

get "/access_token" do
  'access_token: ' + session[:access_token]
end

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'



end
