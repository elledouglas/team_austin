class UsersController < ApplicationController
  
  def index
    @user = User.all

  end
  def new
      @user = User.new
  end

  def show
   @user = User.find(params[:id])
  end



  def create
    @user = User.new(
    email: params[:user][:email],
    password: params[:user][:password],

    )
    # if @user.save
    #   #session keeps your logged in
    #   # session[:user_id] = @user.id
    #
    #   redirect_to root_path
    # else
    #   flash.now[:alert] = @users.errors.full_messages
    #   render:new
  # end
end

#   def edit
#   end
#
#   def destroy
#   end
# end
end
