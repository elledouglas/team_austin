class UsersController < ApplicationController
  # \/ Requires user to be logged in before editing, updating, or viewing index
    before_action :logged_in_user, only: [:index, :edit, :update]

  # \/ Requires that one be the user of the profile page one is trying to edit or destroy
    before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @user = User.all
  end

  def new
      @user = User.new
  end

  def show
   @user = User.find(params[:id])
  #  debugger           #(<----uncomment to use byebug in server)
  end

  def create
    @user = User.new(user_params)

      respond_to do |format|
       if @user.save
         log_in @user
         flash[:success] = "User Profile Successfully Created"
         # Tell the UserMailer to send a welcome email after save
         UserMailer.welcome_email(@user).deliver_now

         format.html { redirect_to(users_path, notice: 'User was successfully created.') }
         format.json { render json: @user, status: :created, location: @user }
       else
         format.html { render action: 'new' }
         format.json { render json: @user.errors, status: :unprocessable_entity }
       end
     end
   end

   def edit
     @user = User.find(params[:id])  # Could technically delete this line because of the correct_user user method and filter? (line 5)
   end

  def update
    @user = User.find(params[:id])  # Could technically delete this line because of the correct_user user method and filter? (line 5)
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to user_profile_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "You have deleted your account, including all profile information!"
    redirect_to users_url
  end

  private

   def user_params
     params.require(:user).permit(:full_name, :email, :password,
                                  :password_confirmation)
   end

   # \/ Before filters

# Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location  # This line uses a method in sessions_helper to store request location so that it may redirect them to that location upon login.
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
