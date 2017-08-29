class UsersController < ApplicationController

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
      if @user.save
        redirect_to user_profile_path(@user)
      else
        render 'new'
      end
    end


    # def create
    #   @user = User.new(
    #   email: params[:user][:email],
    #   password: params[:user][:password],
    #
    #   )
    # if @user.save
    #   #session keeps your logged in
    #   # session[:user_id] = @user.id
    #
    #   redirect_to root_path
    # else
    #   flash.now[:alert] = @users.errors.full_messages
    #   render:new
  # end


#   def edit
#   end
#
#   def destroy
#   end

  private

   def user_params
     params.require(:user).permit(:full_name, :email, :password,
                                  :password_confirmation)
   end

end
