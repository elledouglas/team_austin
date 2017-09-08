def new
  @user = User.new
  # need this for the form_for new.html.erb
end

def show
 @recipe.find(params[:id])
end

def create
  @user = User.new(
  email: params[:user][:email],
  password: params[:user][:password],
  password_confirmation: params[:user][:password_confirmation]
  )

  if @user.save
    #session keeps your logged in
    session[:user_id] = @user.id
    redirect_to root_path
  else
    flash.now[:alert] = @users.errors.full_messages
    render:new
end
